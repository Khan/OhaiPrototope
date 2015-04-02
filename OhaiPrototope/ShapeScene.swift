//
//  ShapeScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on Mar-27-2015.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

class ShapeScene {
	
	let rectLayer: ShapeLayer
	let roundRectLayer: ShapeLayer
	let ovalLayer: ShapeLayer
	let lineLayer: ShapeLayer
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		
	
		self.ovalLayer = ShapeLayer(ovalInRectangle: Rect(x: 100, y: 100, width: 200, height: 100))
		
		self.rectLayer = ShapeLayer(rectangle: Rect(x: 5, y: 25, width: 40, height: 50))
		self.roundRectLayer = ShapeLayer(rectangle: Rect(x: 5, y: 95, width: 400, height: 200), cornerRadius: 50)
	
		self.lineLayer = ShapeLayer(lineFromFirstPoint: Point(x: 100, y: 30), toSecondPoint: Point(x: 200, y: 300))
		
		let polyLayer = ShapeLayer(polygonCenteretAtPoint: Point(x: 100, y: 100), radius: 100, numberOfSides: 6)
		polyLayer.fillColor = Color(hex: 0x9A73AB)
	}
}