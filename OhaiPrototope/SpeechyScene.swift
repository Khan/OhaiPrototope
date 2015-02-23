//
//  SpeechyScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on 2015-02-17.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

class SpeechyScene {
	
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		
		var lastY = 40.0
		
		for index in 1..<5 {
			
			let textLayer = TextLayer(parent: Layer.root, name: "\(index)")
			textLayer.text = "\(index)"
			textLayer.fontSize = 40
			textLayer.originX = 30
			textLayer.originY = lastY
			lastY = textLayer.frameMaxY + 40
			
			textLayer.gestures.append(TapGesture (numberOfTouchesRequired: 1, numberOfTapsRequired: 1) { _ in
				Speech.say(textLayer.text!)
			})
			
		}
		
		
		let textLayer = TextLayer(parent: Layer.root, name: nil)
		textLayer.text = "Tap a number to have it read out loud"
		textLayer.fontSize = 30
		textLayer.moveToCenterOfParentLayer()
		textLayer.gestures.append(TapGesture (numberOfTouchesRequired: 1, numberOfTapsRequired: 1) { _ in
			Speech.say("No silly, tap a number.")
		})
		
	}
}