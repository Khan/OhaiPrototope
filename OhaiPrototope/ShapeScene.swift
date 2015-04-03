//
//  ShapeScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on Mar-27-2015.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

class ShapeScene {
	
	var touchesToFingerCircles = [UITouchID: ShapeLayer]()
	var traceLine: ShapeLayer? = nil
	let grey = Color(hex: 0xEAEAEA)
	
	var line: Line? = nil
	var currentSketch: ShapeLayer? = nil
	var currentSketchTouchID: UITouchID? = nil
	var startPoint: Point? = nil
	var sketchedLines = [ShapeLayer]()
	
	init() {
		Layer.root.backgroundColor = Color.white

		
		// There's a bug in the touch code for drawing lines.
		Layer.root.touchBeganHandler = { touchSequence in
			
			
			if self.currentlyDrawingALine() {
				return
			}
			
			
			if self.touchesToFingerCircles.count >= 2 {
				
				// starting to draw a line!
				let touchPoint = touchSequence.currentSample.globalLocation
				self.startPoint = touchPoint
				self.currentSketch = ShapeLayer(lineFromFirstPoint: touchPoint, toSecondPoint: touchPoint)
				self.currentSketch?.strokeColor = Color.black
				self.currentSketch?.strokeWidth = 5
				self.currentSketchTouchID = touchSequence.id
				
				return
			}
			
			
			let fingerCircle = ShapeLayer(circleCenter: touchSequence.currentSample.globalLocation, radius: 30)
			fingerCircle.fillColor = Color.white
			fingerCircle.strokeColor = self.grey
			self.touchesToFingerCircles[touchSequence.id] = fingerCircle
			
			self.updateLineWithTouchSequence(touchSequence)
		}
		
		Layer.root.touchMovedHandler = { touchSequence in
			
			let circle = self.touchesToFingerCircles[touchSequence.id]
			
			
			
			
			if touchSequence.id == self.currentSketchTouchID {
				
				self.currentSketch?.parent = nil
				self.currentSketch = nil
				
				// This is a stopgap until there's a better way to change the points of a shape and have the frame update
				let firstPoint = self.line!.pointBySolvingForYGivenX(self.startPoint!.x)
				let touchPoint = touchSequence.currentSample.globalLocation
				let secondPoint = self.line!.pointBySolvingForYGivenX(touchPoint.x)
				
				self.currentSketch = ShapeLayer(lineFromFirstPoint: firstPoint, toSecondPoint: secondPoint)
				self.currentSketch?.strokeColor = Color(hex: 0xF84944)
				self.currentSketch?.strokeWidth = 5
				self.currentSketch?.lineCapStyle = .Round
				
			} else if !self.currentlyDrawingALine() {
				// Update the touch circles and line iff we're not sketching
				circle?.position = touchSequence.currentSample.globalLocation
				
				self.updateLineWithTouchSequence(touchSequence)
			}
		}
		
		
		Layer.root.touchEndedHandler = { touchSequence in
			
			let circle = self.touchesToFingerCircles[touchSequence.id]
			
			// if we can't find the circle, and we're drawing a line, then this touch belongs to the sketch touch
			if touchSequence.id == self.currentSketchTouchID {
				if let sketch = self.currentSketch {
					self.sketchedLines.append(sketch)
					self.currentSketch = nil
					self.currentSketchTouchID = nil
				}
				return
			}
			
			circle?.parent = nil
			self.touchesToFingerCircles.removeValueForKey(touchSequence.id)
			
			if self.touchesToFingerCircles.count < 2 {
				self.traceLine?.parent = nil
				self.traceLine = nil
			}
		}
		
	}
	
	
	func updateLineWithTouchSequence(touchSequence: TouchSequence<UITouchID>) {
		if self.touchesToFingerCircles.count == 2 {
			
			let p1 = self.leftmostCircle()!.position
			let p2 = self.rightmostCircle()!.position
			
			self.line = Line(p1: p1, p2: p2)
			
			
			// remove the line first...don't have a good method of changing line points right now?
			self.traceLine?.parent = nil
			self.traceLine = nil
			
			
			let firstPoint = self.line!.pointBySolvingForYGivenX(0)
			let secondPoint = self.line!.pointBySolvingForYGivenX(Layer.root.width)
			
			self.traceLine = ShapeLayer(lineFromFirstPoint: firstPoint, toSecondPoint: secondPoint)
			self.traceLine?.strokeColor = self.grey
		}
	}
	
	
	func currentlyDrawingALine() -> Bool {
		return self.currentSketch != nil
	}
	
	func leftmostCircle() -> ShapeLayer? {
		var leftmostCircle: ShapeLayer? = nil
		
		for key in self.touchesToFingerCircles {
			let circle = self.touchesToFingerCircles[key.0]
			if leftmostCircle == nil || circle!.position.x < leftmostCircle?.position.x {
				leftmostCircle = circle
			}
		}
		
		return leftmostCircle
	}
	
	
	func rightmostCircle() -> ShapeLayer? {
		var rightmostCircle: ShapeLayer? = nil
		
		for key in self.touchesToFingerCircles {
			let circle = self.touchesToFingerCircles[key.0]
			if rightmostCircle == nil || circle!.position.x > rightmostCircle?.position.x {
				rightmostCircle = circle
			}
		}
		
		return rightmostCircle
	}

}


/** Represents a line running through two points in 2D space. */
struct Line {
	
	/** The first point. */
	let p1: Point
	
	/** The second point. */
	let p2: Point
	
	
	/** The slope between the two points. This is known as the 'm' in 'y = mx + b'. */
	var slope: Double {
		return p1.slopeToPoint(p2) ?? 0.0
	}
	
	
	/** The y-intercept of the line. This is known as the 'b' in 'y = mx + b'. */
	var yIntercept: Double {
		return p1.y - (slope * p1.x)
	}
	
	
	/** Solves for Y along the line given an x value, and returns a point of the coordinates. */
	func pointBySolvingForYGivenX(x: Double) -> Point {
		return Point(x: x, y: slope * x + yIntercept)
	}
}