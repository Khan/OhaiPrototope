//
//  RotationGesture.swift
//  OhaiPrototope
//
//  Created by Saniul Ahmed on 27/01/2015.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Foundation

import Prototope

// Draws a large white rounded-rectangle that can be scaled with a two-finger pinch gesture.
// The position of the rectangle is fixed and unaffected by the position of touches
// participating in the scale gesture. After the gesture ends, the rectangle's
// rotation resets using a dynamic animator with the gesture's terminating velocity.
class ScaleGesturePlaypen {
    
    var needyLayer: Layer!
    
    init(){
        Layer.root.backgroundColor = Color(hex: 0x495bbb)
        makeNeedyLayer()
        
        needyLayer.gestures.append(PinchGesture { phase, sequence in
            
            let scale = sequence.currentSample.scale
            let velocity = sequence.currentSample.velocity
            
            self.needyLayer.scale = scale
            
            if phase == .Ended {
                self.needyLayer.animators.scale.target = Point(x: 1, y: 1)
                self.needyLayer.animators.scale.springBounciness = 10
                self.needyLayer.animators.scale.velocity = Point(x: velocity, y: velocity)
            }
            
            })
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

