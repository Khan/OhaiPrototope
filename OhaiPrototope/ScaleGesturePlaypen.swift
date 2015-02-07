//
//  RotationGesture.swift
//  OhaiPrototope
//
//  Created by Saniul Ahmed on 27/01/2015.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Foundation

import Prototope

// Draws a large white rounded-rectangle that can be scaled and rotated with a two-finger gesture.
// The position of the rectangle is fixed and unaffected by the position of touches
// participating in the scale gesture. After the gesture ends, the rectangle's
// rotation resets using a dynamic animator with the gesture's terminating velocity.
class ScaleAndRotateGesturePlaypen {
    
    var needyLayer: Layer!
    
    init(){
        Layer.root.backgroundColor = Color(hex: 0x495bbb)
        makeNeedyLayer()
        
        let pinch = PinchGesture { phase, sequence in
            if phase == .Began {
                self.needyLayer.animators.scale.stop()
            }
            
            let scale = sequence.currentSample.scale
            let velocity = sequence.currentSample.velocity
            self.needyLayer.scale = sequence.currentSample.scale
            
            if phase == .Ended {
                self.needyLayer.animators.scale.target = Point(x: 1, y: 1)
                self.needyLayer.animators.scale.springSpeed = 1
                self.needyLayer.animators.scale.springBounciness = 5
                self.needyLayer.animators.scale.velocity = Point(x: velocity, y: velocity)
            }
            
        }
        
        let rotation = RotationGesture { phase, sequence in
            if phase == .Began {
                self.needyLayer.animators.rotationRadians.stop()
            }

            let rotation = sequence.currentSample.rotationRadians
            let velocity = sequence.currentSample.velocityRadians
            self.needyLayer.rotationRadians = sequence.currentSample.rotationRadians
            
            if phase == .Ended {
                self.needyLayer.animators.rotationRadians.target = 0
                self.needyLayer.animators.rotationRadians.springSpeed = 1
                self.needyLayer.animators.rotationRadians.springBounciness = 10
                self.needyLayer.animators.rotationRadians.velocity = velocity
            }
        }

        let pan = PanGesture { phase, sequence in
            switch phase {
            case .Began:
                self.needyLayer.animators.position.stop()
            case .Changed:
                self.needyLayer.position += sequence.currentSample.locationInLayer(self.needyLayer.parent!) - sequence.previousSample!.locationInLayer(self.needyLayer.parent!)
            case .Ended, .Cancelled:
                var velocity = sequence.currentVelocityInLayer(self.needyLayer.parent!)
                self.needyLayer.animators.position.target = Point(x:384, y:512)
                self.needyLayer.animators.position.velocity = velocity
            }
        }

        let shouldRecognizeSimultaneously: GestureType -> Bool = { gesture in
            return gesture == pinch || gesture == rotation || gesture == pan
        }

        pinch.shouldRecognizeSimultaneouslyWithGesture = shouldRecognizeSimultaneously
        rotation.shouldRecognizeSimultaneouslyWithGesture = shouldRecognizeSimultaneously
pan.shouldRecognizeSimultaneouslyWithGesture = shouldRecognizeSimultaneously
        
        needyLayer.gestures.append(pinch)
        needyLayer.gestures.append(rotation)
        needyLayer.gestures.append(pan)
    }
    
    func gimmeSquare(x:Int = 384) -> Layer! {
        //        // return a rounded white square at some x value (defaults to 384)
        let tempLayer = Layer(parent: Layer.root)
        // tunable(100, name: "layer width") { width in tempLayer.width = width }
        tempLayer.width = 150
        tempLayer.height = 150
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

