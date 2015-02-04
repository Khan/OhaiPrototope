//
//  TouchParticles.swift
//  OhaiPrototope
//
//  Gives ya particle fever.
//  Copyright (c) 2015 Jason Brennan. All rights reserved.
//

import Prototope

class TouchParticles {
	
	var cloudLayer: Layer!
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		makeCloudLayer()

		
    }
    
	func makeCloudLayer() {
		self.cloudLayer = Layer(parent: Layer.root, imageName: "cloud")
		self.cloudLayer.x = 500
		self.cloudLayer.y = 300
		
		self.cloudLayer.gestures.append(TapGesture (numberOfTouchesRequired: 1, numberOfTapsRequired: 1) { _ in
			
			self.makeItRain()
			
		})
	}
	
	func makeItRain() {
		let particle = Particle(image: Image(name: "cloud"))
self.cloudLayer.emitParticle(particle)
	}
}