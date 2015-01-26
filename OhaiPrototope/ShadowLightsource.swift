//
//  ShadowLightsource.swift
//  OhaiPrototope
//
//  Created by Marcos Ojeda on 1/23/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Prototope

class ShadowLightsource {

    var box: Layer!
    var boxShadow: Shadow!

    init (){
        Layer.root.backgroundColor = Color(hex: 0x4DD0E1)
        box = gimmeSquare()
        setupShadowyLayer()

        // as you pan around, use the finger's location to set the position of the light
        Layer.root.gestures.append(PanGesture { phase, centroidSequenc in
            var finger: Point = centroidSequenc.currentSample.globalLocation
            self.boxShadow.radius = self.radiusForPoints(finger, p2: self.box.position)
            self.boxShadow.offset = self.offsetSize(self.box.position, movable: finger)

            self.box.shadow = self.boxShadow
        })
    }

    /**
     * offsetSize, returns a Size sort of like a mini vector from
     * the movable point to the anchor point
     */
    func offsetSize(anchor: Point, movable: Point) -> Size {
        let delta = anchor - movable
        let width = Layer.root.width / 2;
        let height = Layer.root.height / 2;
        let maxHeight = 15.0
        let maxWidth = 12.0

        let offsetWidth: Double = map(delta.x,
            fromInterval: (-1 * width, width),
            toInterval: (-1.0 * maxWidth, maxWidth))
        let offsetHeight: Double = map(delta.y,
            fromInterval:(-1 * height, height),
            toInterval:(-1 * maxHeight, maxHeight))

        return Size(width: offsetWidth, height: offsetHeight)
    }

    /**
     * radiusForPoints returns the a scaled cartesian distance between two points
     * @type {[type]}
     */
    func radiusForPoints(p1: Point, p2: Point, max: Double = 25) -> Double {
        let radius: Double = p1.distanceToPoint(p2)
        let maxRadius = sqrt(pow(Layer.root.bounds.size.height / 2, 2) +
            pow(Layer.root.bounds.size.height / 2, 2));
        return map(radius, fromInterval:(0, maxRadius), toInterval:(0, max))
    }

    /**
     * gimmeSquare returns a vertically centered rounded white square
     * optionally at some x value
     */
    func gimmeSquare(x:Int = 324) -> Layer! {
        let tempLayer = Layer(parent: Layer.root)
        tunable(100, name: "layer width") { width in tempLayer.width = width }
        tempLayer.height = 100
        tempLayer.backgroundColor = Color(white: 1, alpha: 1)
        tempLayer.cornerRadius = 5
        tempLayer.x = Double(x)
        tempLayer.y = 512
        return tempLayer
    }

    /**
     * sets up an initial shadow on the box in our scene
     */
    func setupShadowyLayer() {
        let shadowSize: Size = Size(width:0.0, height:-3.0)
        boxShadow = Shadow(
            color: Color(white:0.2, alpha: 1),
            alpha: 0.8,
            offset: shadowSize,
            radius: 10.0)

        self.box.shadow = boxShadow
    }


}
