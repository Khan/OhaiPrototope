//
//  MainScene.swift
//  OhaiPrototope
//
//  Created by Nefaur Khandker on 1/27/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Prototope

class MainScene {
    
    var bg: Layer!
    var circle: Layer!
    
    init(){
        makeBG()
        makeCircle()
    }
    
    func gimmeSquare(x:Int = 324) -> Layer! {
        // return a rounded white square at some x value (defaults to 324)
        
        let tempLayer = Layer(parent: Layer.root)
        // tunable(100, name: "layer width") { width in tempLayer.width = width }
        tempLayer.width = 100
        tempLayer.height = 100
        tempLayer.backgroundColor = Color(white: 1, alpha: 1)
        tempLayer.cornerRadius = 5
        tempLayer.x = Double(x)
        tempLayer.y = 512
        
        return tempLayer
    }

    func makeBG() {
        bg = Layer(parent: Layer.root)
        bg.backgroundColor = Color(hex: 0xffffff)
        bg.frame = Layer.root.bounds
    }
    
    func makeCircle() {
        let size: Double = 100

        circle = Layer(parent: bg)
        circle.width = size
        circle.height = size
        circle.backgroundColor = Color(hex: 0xff0088)
        circle.cornerRadius = 0.5 * size
        circle.x = 0.5 * bg.width
        circle.y = 0.5 * bg.height
        
        let updatePosition: Layer.TouchHandler = { centroidSequence in
            let point: Point = centroidSequence.currentSample.globalLocation
            self.circle.animators.position.target = point
            self.circle.animators.position.springBounciness = tunable(2.0, name: "bounciness", max: 20.0)
        }
        
        bg.touchBeganHandler = updatePosition
        
        bg.touchMovedHandler = updatePosition
        
        bg.touchEndedHandler = { _ in
            self.circle.animators.position.target = Point(x: 0.5 * self.bg.width, y: 0.5 * self.bg.height)
            self.circle.animators.position.springBounciness = 6.0
        }
    }
    
//    func makeNeedyLayer(){
//        // this layer will also rotate 90 degrees to the right and recoil
//        // from your touch for as long as you press down on it. Letting go
//        // will return it to its original state
//        needyLayer = gimmeSquare(x:444)
//        
//        // starting to touch it will rotate and scale it
//        needyLayer.touchBeganHandler = { _ in
//            self.needyLayer.animators.rotationRadians.target = 1.57
//            self.needyLayer.animators.rotationRadians.springBounciness = 6.0
//        }
//        
//        // letting go restores the values
//        needyLayer.touchEndedHandler = { _ in
//            self.needyLayer.animators.rotationRadians.target = 0
//        }
//    }
    
}
