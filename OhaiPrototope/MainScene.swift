//
//  MainScene.swift
//  OhaiPrototope
//
//  Created by Nefaur Khandker on 1/27/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Prototope

class MainScene: NSObject {
    
    var bg: Layer!
    var circle: Layer!
    var offsetFromCenter: Point!
    var animator: UIDynamicAnimator
    var attachment: UIAttachmentBehavior!
    
    override init() {
        animator = UIDynamicAnimator()
        super.init()
        
        makeBG()
        makeCircle()
    }

    func makeBG() {
        bg = Layer(parent: Layer.root)
        bg.backgroundColor = Color(hex: 0xffffff)
        bg.frame = Rect(Layer.root.size)
    }
    
    func makeCircle() {
        circle = Layer(parent: bg)
        circle.backgroundColor = Color(hex: 0xff0088)
        circle.x = 0.5 * bg.width
        circle.y = 0.5 * bg.height
        tunable(128, name: "size", min: 44, max: 512) { size in
            self.circle.width = size
            self.circle.height = size
            self.circle.cornerRadius = 0.5 * size
        }
        
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
        
//        circle.gestures.append(PanGesture{ phase, centroidSequence in
//            let currentPoint = centroidSequence.currentSample.globalLocation
//            self.pinnedPoint = currentPoint
//            var previousPoint = currentPoint
//            if let previousSample = centroidSequence.previousSample {
//                previousPoint = previousSample.globalLocation
//            }
//            let velocity = centroidSequence.currentVelocityInLayer(self.bg)
//            println(velocity)
//            let centerOfScreen = Point(x: 0.5 * self.bg.width, y: 0.5 * self.bg.height)
//            
//            if phase == .Began {
//                self.circle.animators.position.stop()
//                self.offsetFromCenter = currentPoint - self.circle.position
//            } else if phase == .Changed {
//                self.circle.position += currentPoint - previousPoint
//            } else if phase == .Ended {
//                self.circle.animators.position.target = centerOfScreen
//                self.circle.animators.position.velocity = tunable(1, name: "velocity multiplier", min: 0, max: 20) * velocity
//                self.circle.animators.position.springSpeed = tunable(20, name: "speed", max: 100)
//                self.circle.animators.position.springBounciness = tunable(5, name: "bounciness", max: 20)
//            }
//        })
        
        bg.touchBeganHandler = { centroidSequence in
            let point: CGPoint = CGPoint(centroidSequence.currentSample.globalLocation)
            self.attachment = UIAttachmentBehavior(item: self.circle, attachedToAnchor: point)
            self.animator.addBehavior(self.attachment)
        }
        
        bg.touchEndedHandler = { centroidSequence in
            self.animator.removeBehavior(self.attachment)
            self.attachment = nil
        }
    }
    
}
