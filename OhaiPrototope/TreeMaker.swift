//
//  TreeMaker.swift
//  OhaiPrototope
//
//  Adapted from Bret Victor's tree in Inventing on Principle.
//

import Prototope

class TreeMaker {


	let trunkColor = Color.brown

	var treeContainer: Layer!
	var leafContainer: Layer!
	var lastAvailableLeafInCache = -1

	init(){
		leafContainer = Layer()
		leafContainer.zPosition = 100

		makeTree()
		Layer.root.backgroundColor = Color.white
		Layer.root.gestures = [
			TapGesture(handler: { _ in
				self.makeTree()
			})
		]
	}


	func makeTree() {
		if (treeContainer != nil) {
			if lastAvailableLeafInCache >= 0 {
				leafContainer.removeAllSublayers()
			}
			lastAvailableLeafInCache = leafContainer.sublayers.count - 1
			treeContainer.parent = nil
		}

		treeContainer = Layer()
		treeContainer.frame = Layer.root.bounds
		leafContainer.frame = treeContainer.frame
		drawBranches(parent: treeContainer, level: 0, radians: -M_PI / 2, position: Point(x: Layer.root.x, y: Layer.root.height), width: 30)
	}


	func drawBranches(parent parent: Layer, level: Int, radians: Double, position: Point, width: Double) {
		let lowerBranchLength = tunable(62, name: "Branch length - lower", min: 1, max: 100)
		let upperBranchLength = tunable(3, name: "Branch length - upper", min: 1, max: 100)
		let branchLengthRangeFactor = tunable(0.3, name: "Branch length - range factor", min: 0, max: 0.9)
		let maxLevel = 12

		var length = map(Double(level), fromInterval: (1, 12), toInterval: (lowerBranchLength, upperBranchLength)) * randomInterval(1 - branchLengthRangeFactor, 1 + branchLengthRangeFactor)
		if (level == 0) {
			length = tunable(110, name: "trunk length", min: 20, max: 300)
		}

		let branchSegment = Layer(parent: parent)
		branchSegment.anchorPoint = Point(x: 0, y: 0.5)
		branchSegment.backgroundColor = trunkColor
		branchSegment.position = position
		branchSegment.rotationRadians = radians
		branchSegment.width = length
		branchSegment.height = width

		let widthFactor = tunable(0.7, name: "Branch width factor", min: 0.1, max: 0.9)
		let branchJoinLength = length - width
		let branchTipPosition = Point(x: position.x + cos(radians) * branchJoinLength, y: position.y + sin(radians) * branchJoinLength)

		let angleRange = tunable(0.10, name: "Branching angle range", min: 0, max: 0.5)

		if (level < 6) {
			drawBranches(parent: parent, level: level + 1, radians: radians + randomInterval(-0.05 - angleRange, -0.05) * M_PI, position: branchTipPosition, width: width * widthFactor)
			drawBranches(parent: parent, level: level + 1, radians: radians + randomInterval(0.05 + angleRange, 0.05) * M_PI, position: branchTipPosition, width: width * widthFactor)
		} else if (level < 12) {
			drawBranches(parent: parent, level: level + 1, radians: radians + randomInterval(-angleRange, angleRange) * M_PI, position: branchTipPosition, width: width * widthFactor)
		}

		let leafIntroductionHeight = Double(maxLevel) * tunable(0.3, name: "Leaf introduction height", min: 0, max: 1)
		if (level > Int(leafIntroductionHeight)) {
			drawLeaves(parent: leafContainer, from: branchSegment.position, to: branchTipPosition)
		}
	}

	func drawLeaves(parent parent: Layer, from: Point, to: Point) {
	let leavesPerBranchSegment = Int(tunable(10, name: "leaves per segment", min: 0, max: 25))

		for leafIndex in 0..<leavesPerBranchSegment {
			var x = interpolate(from: from.x, to: to.x, at: randomInterval(0, 1)) + randomInterval(-10, 10)
			var y = interpolate(from: from.y, to: to.y, at: randomInterval(0, 1)) + randomInterval(-10, 10)

			var leaf: ShapeLayer!
			if lastAvailableLeafInCache > 0 {
				leaf = leafContainer.sublayers[lastAvailableLeafInCache] as! ShapeLayer
				leaf.x = x
				leaf.y = y
				lastAvailableLeafInCache--
			} else {
				leaf = makeLeaf(parent: parent, point: Point(x: x, y: y))
			}

			let flowerHue = tunable(0.32, name: "leaf hue", min: 0, max: 1)
			let hueRange = 0.05
			let flowerSaturation = tunable(0.46, name: "leaf saturation", min: 0, max: 1)
			let saturationRange = 0.05
			let flowerBrightness = tunable(0.8, name: "leaf brightness", min: 0, max: 1)
			let brightnessRange = 0.05
			let flowerAlpha = tunable(0.67, name: "leaf alpha", min: 0, max: 1)
			leaf.fillColor = Color(
				hue: flowerHue + randomInterval(-hueRange, hueRange),
				saturation: flowerSaturation + randomInterval(-saturationRange, saturationRange),
				brightness: flowerBrightness + randomInterval(-brightnessRange, brightnessRange)
			)
		}
	}

	func makeLeaf(parent parent: Layer, point: Point) -> ShapeLayer {
		let flowerHue = tunable(0.32, name: "leaf hue", min: 0, max: 1)
		let hueRange = 0.05
		let flowerSaturation = tunable(0.46, name: "leaf saturation", min: 0, max: 1)
		let saturationRange = 0.05
		let flowerBrightness = tunable(0.8, name: "leaf brightness", min: 0, max: 1)
		let brightnessRange = 0.05
		let flowerAlpha = tunable(0.67, name: "leaf alpha", min: 0, max: 1)


		var leaf = ShapeLayer(circleCenter: point, radius: randomInterval(2, 5), parent: parent)
		leaf.alpha = flowerAlpha
		leaf.strokeColor = nil
		leaf.zPosition = 100

		return leaf
	}

	func randomInterval(min: Double, _ max: Double) -> Double {
		return drand48() * (max - min) + min
	}
    
    var catLayer: Layer!
    


}