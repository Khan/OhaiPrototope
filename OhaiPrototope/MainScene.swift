//
//  MainScene.swift
//  OhaiPrototope
//
//  Created by Nefaur Khandker on 1/27/15.
//  Copyright (c) 2015 Khan Academy. All rights reserved.
//

import Prototope

class Behavior {

    let layer: DynamicLayer
    var gravityFieldActive: Bool
    var touchOffsetFromCenter: Point?
    
    init(targetLayer: DynamicLayer) {
        layer = targetLayer

        self.gravityFieldActive = true
        Heartbeat(handler: { heartbeat in
            if self.gravityFieldActive {
                let p = self.layer.parent
                if let parent = p {
                    let centerOfParent = Point(x: 0.5 * parent.width, y: 0.5 * parent.height)
                    let center = self.layer.position
                    let distance = center.distanceToPoint(centerOfParent)
                    let gravity = 100 * (centerOfParent - center)
                    let friction = -10 * self.layer.velocity
                    let netForce = gravity + friction
                    self.layer.netForce = netForce
                }
            }
        })

        layer.gestures.append(PanGesture{ phase, centroidSequence in
            let p = self.layer.parent
            if let parent = p {
                let currentPoint = centroidSequence.currentSample.globalLocation
                var previousPoint = currentPoint
                if let previousSample = centroidSequence.previousSample {
                    previousPoint = previousSample.globalLocation
                }
                let velocity = centroidSequence.currentVelocityInLayer(parent)
                let centerOfParent = Point(x: 0.5 * parent.width, y: 0.5 * parent.height)
                
                if phase == .Began {
                    self.gravityFieldActive = false
                    self.layer.stop()
                    self.touchOffsetFromCenter = currentPoint - self.layer.position
                } else if phase == .Changed {
                    self.layer.position += currentPoint - previousPoint
                } else if phase == .Ended {
                    let impulse = 100 * velocity
                    println(impulse)
                    self.layer.applyImpulse(impulse)
                    self.touchOffsetFromCenter = nil
                    self.gravityFieldActive = true
                }
            }
        })
        
//        bg.gestures.append(TapGesture{ location in
//            let centerOfCircle = self.circle.position
//            let centerOfTouch = location
//            let impulse = (centerOfTouch - centerOfCircle).normalized() * 10000
//            self.circle.applyImpulse(impulse: impulse)
//            })
//        
//        let updateTargetPosition: Layer.TouchHandler = { centroidSequence in
//            let point: Point = centroidSequence.currentSample.globalLocation
//            self.circle.animators.position.target = point
//            self.circle.animators.position.springSpeed = tunable(20, name: "speed", max: 100)
//            self.circle.animators.position.springBounciness = tunable(5, name: "bounciness", max: 20)
//        }
//
//        let returnToCenter: Layer.TouchHandler = { _ in
//            self.circle.animators.position.target = Point(x: 0.5 * self.bg.width, y: 0.5 * self.bg.height)
//            self.circle.animators.position.springSpeed = tunable(20, name: "speed", max: 100)
//            self.circle.animators.position.springBounciness = tunable(5, name: "bounciness", max: 20)
//        }
//
//        bg.touchBeganHandler = updateTargetPosition
//        bg.touchMovedHandler = updateTargetPosition
//        bg.touchEndedHandler = returnToCenter
    }

}

class MainScene {
    
    var bg: Layer!
    var circle: DynamicLayer!
    
    init() {
        makeBG()
        makeCircle()
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
        
        let behavior = Behavior(targetLayer: circle)
    }
    
}
