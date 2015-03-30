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
	let pathLayer: ShapeLayer
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		
		self.rectLayer = ShapeLayer(path: Path(rectangle: Rect(x: 5, y: 25, width: 40, height: 50)))
		self.roundRectLayer = ShapeLayer(path: Path(rectangle: Rect(x: 5, y: 95, width: 40, height: 20), cornerRadius: 5))
		self.ovalLayer = ShapeLayer(path: Path(ovalInRectangle: Rect(x: 5, y: 190, width: 40, height: 30)))
		
		self.lineLayer = ShapeLayer(path: Path(lineFromFirstPoint: Point(x: 100, y: 30), toSecondPoint: Point(x: 200, y: 300)))
		
		let path = Path()
//		path.addPoint(Point())
		path.addPoint(Point(x: 40, y: 90))
		path.addPoint(Point(x: 90, y: 40))
		path.addPoint(Point(x: 140, y: 90))
//		path.closed = true
		

		
		self.pathLayer = ShapeLayer(path: path)
		self.pathLayer.strokeColor = Color.red
		self.pathLayer.fillColor = nil
		self.pathLayer.strokeWidth = 10
		self.pathLayer.capStyle = .Round
		self.pathLayer.lineJoinStyle = .Round
		
		self.pathLayer.moveToCenterOfParentLayer()
		
		self.rectLayer.backgroundColor = Color.lightGray
		self.roundRectLayer.backgroundColor = Color.lightGray
		self.ovalLayer.backgroundColor = Color.lightGray
		self.lineLayer.backgroundColor = Color.lightGray
		self.pathLayer.backgroundColor = Color.lightGray
	}
}