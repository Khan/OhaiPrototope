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
    var position: Point

    init(_ layer: DynamicLayer) {
        self.dynamicLayer = layer
        self.position = Point()
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
                self.dynamicLayer.netForce = netForce
            }
        })
    }

}

class DragBehavior: Behavior {

    let dynamicLayer: DynamicLayer
    let gravityBehavior: Behavior
    
    init(_ layer: DynamicLayer, gravityBehavior: Behavior) {
        self.dynamicLayer = layer
        self.gravityBehavior = gravityBehavior
        super.init(layer)

        self.dynamicLayer.touchBeganHandler = { centroidSequence in
            if self.active {
                self.gravityBehavior.active = false
                self.dynamicLayer.stop()
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
        }
    }

}

class AttractBehavior: Behavior {
    
    let attractedLayer: DynamicLayer
    let dragBehavior: Behavior
    let gravityBehavior: Behavior
    
    init(_ layer: Layer, attractedLayer: DynamicLayer, dragBehavior: Behavior, gravityBehavior: Behavior) {
        self.attractedLayer = attractedLayer
        self.dragBehavior = dragBehavior
        self.gravityBehavior = gravityBehavior
        super.init(layer)
        
        self.layer.touchBeganHandler = { centroidSequence in
            self.dragBehavior.active = false
            self.gravityBehavior.active = false
            self.attractedLayer.stop()

//            let point: Point = centroidSequence.currentSample.globalLocation
//            targetLayer.animators.position.target = point
//            targetLayer.animators.position.springSpeed = tunable(20, name: "speed", max: 100)
//            targetLayer.animators.position.springBounciness = tunable(5, name: "bounciness", max: 20)
        }
        self.layer.touchMovedHandler = { centroidSequence in
//            let targetLayer = self.circleBehavior.targetLayer
//            let point: Point = centroidSequence.currentSample.globalLocation
//            targetLayer.animators.position.target = point
//            targetLayer.animators.position.springSpeed = tunable(20, name: "speed", max: 100)
//            targetLayer.animators.position.springBounciness = tunable(5, name: "bounciness", max: 20)
        }
        self.layer.touchEndedHandler = { _ in
            self.gravityBehavior.active = true
            self.dragBehavior.active = true
        }
    }
}

class MainScene {
    
    var bg: Layer!
    var circle: DynamicLayer!
    
    init() {
        makeBG()
        makeCircle()
        setupBehaviors()
    }

    func makeBG() {
        bg = Layer(parent: Layer.root)
        bg.backgroundColor = Color(hex: 0xffffff)
        bg.frame = Layer.root.bounds
    }
    
    func makeCircle() {
        circle = DynamicLayer(parent: bg)
        circle.backgroundColor = Color(hex: 0xff0088)
        circle.x = 0.5 * bg.width
        circle.y = 0.5 * bg.height
        tunable(100, name: "size", min: 44, max: 512) { size in
            self.circle.width = size
            self.circle.height = size
            self.circle.cornerRadius = 0.5 * size
            self.circle.mass = size / 100
            println(self.circle.mass)
        }
    }
    
    func setupBehaviors() {
        let gravityBehavior = GravityBehavior(circle)
        gravityBehavior.position = bg.bounds.center
        let dragBehavior = DragBehavior(circle, gravityBehavior: gravityBehavior)
        let attractBehavior = AttractBehavior(bg, attractedLayer: circle, dragBehavior: dragBehavior, gravityBehavior: gravityBehavior)
    }
}
