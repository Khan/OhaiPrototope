//
//  TouchParticles.swift
//  OhaiPrototope
//
//  Gives ya particle fever.
//  Copyright (c) 2015 Jason Brennan. All rights reserved.
//

import Prototope

/** Touch the cloud, make it rain; touch the layer, make it sparkle. */
class TouchParticles {
	
	var cloudLayer: Layer!
	var sparkleLayer: Layer!
	
	var rainEmitter: ParticleEmitter!
	var sparkleEmitter: ParticleEmitter!
	
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		makeCloudLayer()
		makeSparkleLayer()
		
		
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
	
	
	func makeSparkleLayer() {
		self.sparkleLayer = Layer(parent: Layer.root)
		self.sparkleLayer.x = 324
		self.sparkleLayer.y = 512
		self.sparkleLayer.width = 100
		self.sparkleLayer.height = 100
		self.sparkleLayer.cornerRadius = 5
		self.sparkleLayer.backgroundColor = Color(hex: 0x4A4A4A)
		
		self.sparkleLayer.gestures.append(TapGesture (numberOfTouchesRequired: 1, numberOfTapsRequired: 1) { _ in
			
			self.makeItSparkle()
			
			})
	}
	
	func makeItRain() {
		let raindrop = Particle(imageName: "drop", preset: .Rain)
		self.rainEmitter = ParticleEmitter(particles: [raindrop])
		Layer.root.addParticleEmitter(self.rainEmitter)
		
		// Layer sets these properties automatically, but I want to reset them manually.
		self.rainEmitter.size = self.cloudLayer.size
		self.rainEmitter.position = self.cloudLayer.position
	}
	
	
	func makeItSparkle() {
		let sparkle = Particle(imageName: "sparkles", preset: .Sparkle)
		self.sparkleEmitter = ParticleEmitter(particles: [sparkle])
		self.sparkleEmitter.shape = kCAEmitterLayerRectangle
		self.sparkleLayer.addParticleEmitter(self.sparkleEmitter, forDuration: 3)
		afterDuration(1) {
self.sparkleEmitter.birthRate = 0
}
		
	}
}