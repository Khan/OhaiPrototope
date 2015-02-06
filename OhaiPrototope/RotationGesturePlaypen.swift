//
//  RotationGesture.swift
//  OhaiPrototope
//
//  Created by Saniul Ahmed on 27/01/2015.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Foundation

import Prototope

// Draws a large white rounded-rectangle that can be rotated with a two-finger gesture.
// The position of the rectangle is fixed and unaffected by the position of touches
// participating in the rotation gesture. After the gesture ends, the rectangle's
// rotation resets using a dynamic animator with the gesture's terminating velocity.
class RotationGesturePlaypen {
    
    var needyLayer: Layer!
    
    init(){
        Layer.root.backgroundColor = Color(hex: 0x535F71)
        makeNeedyLayer()
        
        var initialRotation: Double = 0
        needyLayer.gestures.append(RotationGesture { phase, sequence in

            let rotation = sequence.currentSample.rotationRadians
            let velocity = sequence.currentSample.velocityRadians
            
            if phase == .Began {
                initialRotation = self.needyLayer.rotationRadians
            }
            
            self.needyLayer.rotationRadians = initialRotation + rotation
            
            if phase == .Ended {
                initialRotation = 0
                self.needyLayer.animators.rotationRadians.target = 0
                let animation = SpringAnimation(velocity: velocity, springBounciness: 10)
                self.needyLayer.animators.rotationRadians.animationKind = animation
            }
            
            })
    }
    
    func gimmeSquare(x:Int = 384) -> Layer! {
//        // return a rounded white square at some x value (defaults to 384)
        let tempLayer = Layer(parent: Layer.root)
        // tunable(100, name: "layer width") { width in tempLayer.width = width }
        tempLayer.width = 200
        tempLayer.height = 200
        tempLayer.backgroundColor = Color(white: 1, alpha: 1)
        tempLayer.cornerRadius = 5
        tempLayer.x = Double(x)
        tempLayer.y = 512
        
        return tempLayer
    }

    func makeNeedyLayer(){
        needyLayer = gimmeSquare()
    }

}

