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
	var rainEmitter: ParticleEmitter!
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		makeCloudLayer()

		
    }
    
	func makeCloudLayer() {
		self.cloudLayer = Layer(parent: Layer.root, imageName: "cloud")
		self.cloudLayer.x = 500
		self.cloudLayer.y = 100
		
		self.cloudLayer.gestures.append(TapGesture (numberOfTouchesRequired: 1, numberOfTapsRequired: 1) { _ in
			
			self.makeItRain()
			
		})
		
		self.cloudLayer.gestures.append(PanGesture { _, centroidSequenc in
            var finger: Point = centroidSequenc.currentSample.globalLocation
            self.cloudLayer.x = finger.x
			self.rainEmitter.x = finger.x
        })
	}
	
	func makeItRain() {
		let raindrop = Particle(image: Image(name: "drop"), preset: .Rain)
		self.rainEmitter = ParticleEmitter(particles: [raindrop])
		self.rainEmitter.position = self.cloudLayer.position
		Layer.root.addParticleEmitter(self.rainEmitter)
	}
}