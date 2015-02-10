//
//  TouchUnicorns.swift
//  OhaiPrototope
//
//  Because Unicorns love to be touched
//  Copyright (c) 2015 May-Li Khoe. All rights reserved.
//

import Prototope

class TouchUnicorns {

    var touchMeLayer: Layer!
    var unicornLayer: Layer!


    init(){
        Layer.root.backgroundColor = Color(hex: 0xFF31A0)
        //makeTouchMeLayer()
        makeUnicornLayer()

        Layer.root.gestures.append(PanGesture( handler: { phase, centroidSequenc in
            var finger: Point = centroidSequenc.currentSample.globalLocation

            for touch in centroidSequenc.samples {
                var touchLoc: Point = touch.globalLocation
                self.gimmeSparkle(touchLoc.x, y:touchLoc.y)
            }

            self.unicornLayer.x = finger.x
            self.unicornLayer.y = finger.y
            self.unicornLayer.zPosition = 1.0

        }))

    }

    func gimmeSparkle(x:Double, y:Double) -> Layer {
        //return a sparkle at the x and y value provided

        let sparkleLayer = Layer(parent: Layer.root, imageName: "star")
        sparkleLayer.x = Double(x)
        sparkleLayer.y = Double(y)

        return sparkleLayer

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

    func makeTouchMeLayer(){
        // touching this layer will rotate it 90 degrees to the right
        touchMeLayer = gimmeSquare()

        touchMeLayer.touchBeganHandler = { _ in
            Layer.animateWithDuration(0.35, curve: .EaseInOut, animations: {
                 self.touchMeLayer.rotationDegrees = 90
            })
        }

        touchMeLayer.touchEndedHandler = { _ in
            Layer.animateWithDuration(0.35, curve: .EaseInOut, animations: {
                 self.touchMeLayer.rotationDegrees = 0
            })
        }
    }

    func makeUnicornLayer() {

        unicornLayer = Layer(parent: Layer.root, imageName: "unicorn")
        unicornLayer.x = 400
        unicornLayer.y = 512

    }






}
