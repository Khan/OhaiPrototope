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
		
		self.rectLayer = ShapeLayer(rectangle: Rect(x: 5, y: 25, width: 40, height: 50))
		self.roundRectLayer = ShapeLayer(rectangle: Rect(x: 5, y: 95, width: 40, height: 20), cornerRadius: 5)
		self.ovalLayer = ShapeLayer(ovalInRectangle: Rect(x: 5, y: 190, width: 40, height: 30))
		
		self.lineLayer = ShapeLayer(lineFromFirstPoint: Point(x: 100, y: 30), toSecondPoint: Point(x: 200, y: 300))
		
		self.rectLayer.backgroundColor = Color.lightGray
		self.roundRectLayer.backgroundColor = Color.lightGray
		self.ovalLayer.backgroundColor = Color.lightGray
		self.lineLayer.backgroundColor = Color.lightGray
	}
}