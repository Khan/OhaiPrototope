//
//  MainScene.swift
//  OhaiPrototope
//
//  Created by Nefaur Khandker on 1/27/15.
//  Copyright (c) 2015 Khan Academy. All rights reserved.
//

import Prototope

class Behavior {
    let layer: Layer
    var active: Bool
    
    init(_ layer: Layer) {
        self.layer = layer
        self.active = true
    }
}

class GravityBehavior: Behavior {
    
    let dynamicLayer: DynamicLayer
    let id: String
    var position: Point

    init(_ layer: DynamicLayer, id: String, position: Point = Point()) {
        self.dynamicLayer = layer
        self.id = id
        self.position = position
        super.init(layer)

        Heartbeat(handler: { heartbeat in
            if self.active {
                let targetPosition = self.position
                let position = self.layer.position
                let g = tunable(100, name: "gravity", min: 0, max: 10000)
                let f = tunable(10, name: "friction", min: 0, max: 10000)
                
                let distance = position.distanceToPoint(targetPosition)
                let gravity = g * (targetPosition - position)
                let friction = -f * self.dynamicLayer.velocity
                let netForce = gravity + friction
                self.dynamicLayer.applyForce(id, force: netForce)
            } else {
                self.dynamicLayer.removeForce(id)
            }
        })
    }

}

class DragBehavior: Behavior {

    let dynamicLayer: DynamicLayer
    let gravityBehavior: Behavior
    var dragging: Bool
    
    init(_ layer: DynamicLayer, gravityBehavior: Behavior) {
        self.dynamicLayer = layer
        self.gravityBehavior = gravityBehavior
        self.dragging = false
        super.init(layer)

        self.dynamicLayer.touchBeganHandler = { centroidSequence in
            let id = centroidSequence.id
            println(id)
            if self.active {
                self.gravityBehavior.active = false
                self.dynamicLayer.stop()
                self.dragging = true
            }
        }
        
        self.dynamicLayer.touchMovedHandler = { centroidSequence in
            let currentPoint = centroidSequence.currentSample.globalLocation
            var previousPoint = currentPoint
            if let previousSample = centroidSequence.previousSample {
                previousPoint = previousSample.globalLocation
            }
            
            self.dynamicLayer.position += currentPoint - previousPoint
        }
        
        self.dynamicLayer.touchEndedHandler = { centroidSequence in
            let p = self.dynamicLayer.parent
            var velocity = Vector()
            if let parent = p {
                velocity = centroidSequence.currentVelocityInLayer(parent)
            }
            let impulse = 100 * velocity
            self.dynamicLayer.applyImpulse(impulse)

            self.gravityBehavior.active = true
            self.dragging = false
        }
    }

}

class AttractionBehavior: Behavior {
    
    let attractedLayer: DynamicLayer
    let ambientGravity: GravityBehavior
    var dragTouch: UITouchID? // The touch (if any) that's dragging the layer
    var gravityTouches: [UITouchID: TouchSequence<UITouchID>] // TouchSequence IDs to TouchSequence objects
    var gravityFields: [UITouchID: GravityBehavior]
    
    init(_ layer: Layer, attractedLayer: DynamicLayer, ambientGravity: GravityBehavior) {
        self.attractedLayer = attractedLayer
        self.ambientGravity = ambientGravity
        self.dragTouch = nil
        self.gravityTouches = Dictionary()
        self.gravityFields = Dictionary()
        super.init(layer)
        
        self.layer.touchBeganHandler = { centroidSequence in
            self.ambientGravity.active = false
            
            let id = centroidSequence.id
            let position = centroidSequence.currentSample.locationInLayer(self.layer)
            println(position)
            if (attractedLayer.frame.contains(position)) {
                println("Got it!")
                self.dragTouch = id
            } else {
                let stringID: String = id.description
                self.gravityTouches[id] = centroidSequence
                self.gravityFields[id] = GravityBehavior(self.attractedLayer, id: stringID, position: position)
            }
        }
        self.layer.touchMovedHandler = { centroidSequence in
            let id = centroidSequence.id
            let position = centroidSequence.currentSample.locationInLayer(self.layer)
            if self.dragTouch == id {
                let currentPoint = position
                var previousPoint = currentPoint
                if let previousSample = centroidSequence.previousSample {
                    previousPoint = previousSample.globalLocation
                }
                self.attractedLayer.position += currentPoint - previousPoint
            } else {
                self.gravityTouches[id] = centroidSequence
                if let gravity = self.gravityFields[id] {
                    gravity.position = position
                    println(position)
                }
            }
        }
        self.layer.touchEndedHandler = { centroidSequence in
            let id = centroidSequence.id
            if id == self.dragTouch {
                var velocity = centroidSequence.currentVelocityInLayer(self.layer)
                let impulse = 100 * velocity
                self.attractedLayer.applyImpulse(impulse)
                
                self.dragTouch = nil
            } else {
                if let gravity = self.gravityFields[id] {
                    gravity.active = false
                    self.gravityFields.removeValueForKey(id)
                }
                self.gravityTouches.removeValueForKey(id)
            }
            if self.gravityTouches.count == 0 {
                self.ambientGravity.active = true
            }
        }
    }
}

class MainScene {
    
    var bg: Layer!
    var circle: DynamicLayer!
    let ambientGravity: GravityBehavior
    let attractionBehavior: AttractionBehavior
    
    init() {
        bg = Layer(parent: Layer.root)
        bg.backgroundColor = Color(hex: 0xffffff)
        bg.frame = Layer.root.bounds
        
        circle = DynamicLayer(parent: bg)
        circle.backgroundColor = Color(hex: 0xff0088)
        circle.x = 0.5 * bg.width
        circle.y = 0.5 * bg.height

        self.ambientGravity = GravityBehavior(circle, id: "ambient", position: bg.bounds.center)
        self.attractionBehavior = AttractionBehavior(bg, attractedLayer: circle, ambientGravity: ambientGravity)
        
        tunable(100, name: "size", min: 44, max: 512) { size in
            self.circle.width = size
            self.circle.height = size
            self.circle.cornerRadius = 0.5 * size
            self.circle.mass = size / 100
            println(self.circle.mass)
        }
    }
}
