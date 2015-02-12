//
//  ScrollScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on 2015-02-11.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

/** Scrolls! */
class ScrollScene {
	let scrollLayer: ScrollLayer
	
	let lilLayers: [Layer]
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		
		
		self.scrollLayer = ScrollLayer(parent: Layer.root, name: "scroller")

		self.scrollLayer.size = Size(width: 200, height: 500)
		self.scrollLayer.frame.origin = Point(x: 200, y: 200)
		
		self.scrollLayer.backgroundColor = Color.white
		self.scrollLayer.cornerRadius = 5
		
		var layers = [Layer]()
		for index in 0..<5 {
			let layer = Layer(parent: self.scrollLayer, name: "layer", viewClass: nil)
			
			layer.size = Size(width: self.scrollLayer.width - 20, height: 100)
			layer.frame.origin = Point(x: 10.0, y: Double(index) * 140.0)
			layer.backgroundColor = Color(hex: 0x70B21A)
			layer.cornerRadius = 5
			layers.append(layer)
			
		}
		
		self.lilLayers = layers
		self.scrollLayer.updateScrollableSizeToFitSublayers()
	}
}