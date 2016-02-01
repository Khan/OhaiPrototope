//
//  MainScene.swift
//  OhaiPrototope
//
//  Modeled after http://framerjs.com/examples/preview/#click-events.framer#code
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Prototope

class TouchAnimators {

    var spinnyLayer: Layer!
    var needyLayer: Layer!

    init(){
        Layer.root.backgroundColor = Color(hex: 0x535F55)
        makeSpinnyLayer()
        makeNeedyLayer()
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

    func makeSpinnyLayer(){
        // touching this layer will rotate it 90 degrees to the right
        spinnyLayer = gimmeSquare()

        spinnyLayer.touchBeganHandler = { _ in
            Layer.animateWithDuration(0.35, curve: .EaseInOut, animations: {
                 self.spinnyLayer.rotationDegrees = 90
            })
        }

        spinnyLayer.touchEndedHandler = { _ in
            Layer.animateWithDuration(0.35, curve: .EaseInOut, animations: {
                 self.spinnyLayer.rotationDegrees = 0
            })
        }
    }

    func makeNeedyLayer(){
        // this layer will also rotate 90 degrees to the right and recoil
        // from your touch for as long as you press down on it. Letting go
        // will return it to its original state
        needyLayer = gimmeSquare(444)

        // starting to touch it will rotate and scale it
        needyLayer.touchBeganHandler = { _ in
            self.needyLayer.animators.rotationRadians.target = 1.57
            self.needyLayer.animators.rotationRadians.springBounciness = 6.0
        }

        // letting go restores the values
        needyLayer.touchEndedHandler = { _ in
            self.needyLayer.animators.rotationRadians.target = 0
        }
    }

}
