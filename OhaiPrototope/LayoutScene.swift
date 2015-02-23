//
//  LayoutScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on 2015-02-13.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

class LayoutScene {
	
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		
		var layers = [Layer]()
		
		var lastLayer: Layer? = nil
		
		for index in 0..<5 {
			let layer = Layer(parent: Layer.root, name: "layer", viewClass: nil)
			
			layer.size = Size(width: 100, height: 100)
			
			if let previousLayer = lastLayer {
				layer.moveBelowSiblingLayer(previousLayer, margin: 20)
			} else {
				layer.originY = 40
			}
			layer.moveToHorizontalCenterOfParentLayer()
			
			layer.backgroundColor = Color(hex: 0x70B21A)
			layer.cornerRadius = 5
			layers.append(layer)
			lastLayer = layer
		}
		
	}
}
