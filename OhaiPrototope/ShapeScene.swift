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
	let chainLayer: ShapeLayer
	
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
		self.pathLayer.lineCapStyle = .Round
		self.pathLayer.lineJoinStyle = .Round
		
		self.pathLayer.moveToCenterOfParentLayer()
		
		var points = 20
		var length = 25
		let chainPath = Path()
		
		var startPoint = Point(x: 0, y: 100)
		for var i = 0; i < points; i++ {
			chainPath.addPoint(startPoint + Point(x: Double(i * length), y: 0.0))
		}
		
		
		
		self.chainLayer = ShapeLayer(path: chainPath)
		self.chainLayer.strokeWidth = 20
		self.chainLayer.lineCapStyle = .Round
		
		self.chainLayer.moveToCenterOfParentLayer()
		self.chainLayer.fillColor = nil
		self.chainLayer.lineJoinStyle = .Round

		
		Layer.root.touchMovedHandler = { (touchSequence: TouchSequence) in
			
			let touchPoint = touchSequence.currentSample.globalLocation
			let firstSegment = Segment(point: touchPoint)
			chainPath.replaceSegmentAtIndex(0, withSegment: firstSegment)
			
			for var i = 0; i < points - 1; i++ {
				var segment = chainPath.segments[i]
				var nextSegment = chainPath.segments[i + 1]
				var vector = segment.point - nextSegment.point
				var vectorLength = vector.length
				var scale = Double(length) / vectorLength
				vector.x = vector.x * scale
				vector.y = vector.y * scale
				
				var newNextSegment = Segment(point: segment.point - vector)
				chainPath.replaceSegmentAtIndex(i + 1, withSegment: newNextSegment)
				
			}
			self.chainLayer.updatePath(chainPath)
		}
		
		self.rectLayer.backgroundColor = Color.lightGray
		self.roundRectLayer.backgroundColor = Color.lightGray
		self.ovalLayer.backgroundColor = Color.lightGray
		self.lineLayer.backgroundColor = Color.lightGray
		self.pathLayer.backgroundColor = Color.lightGray
	}
}