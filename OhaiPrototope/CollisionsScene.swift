//
//  CollisionsScene.swift
//  OhaiPrototope
//
//  Created by Saniul Ahmed on 07/02/2015.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Foundation
import Prototope

class CollisionsScene {
    var catLayer: Layer!
    var rainbowLayer: Layer!

    init() {
        Layer.root.backgroundColor =  Color(hex: 0x000000)
        makeRainbow()
        makeCatLayer()
        
        setupCollisions()
    }
    
    func makeRainbow() {
        rainbowLayer = Layer(parent: Layer.root, imageName: "rainbow")
        rainbowLayer.width *= 5
        rainbowLayer.x = 100
        rainbowLayer.y = 300
    }
    
    func makeCatLayer() {
        catLayer = Layer(parent: Layer.root, imageName: "cat")
        catLayer.x = 400
        catLayer.y = 512
        
        //insert code to bring cat back here.
        
        catLayer.gestures.append(PanGesture(cancelsTouchesInLayer: false) { phase, sequence in
            switch phase {
            case .Began: break // Do nothing
            case .Changed:
                self.catLayer.position += sequence.currentSample.locationInLayer(self.catLayer.parent!) - sequence.previousSample!.locationInLayer(self.catLayer.parent!)
            case .Ended, .Cancelled:
            break;
                
            }
            })
    }
    
    func setupCollisions() {
        when(catLayer).enters(rainbowLayer) {
            self.makeSparkle(catLayer)
        }
    }
    
    func makeSparkle(layer: Layer) {
        var sparkle = Particle(imageName: "sparkles", preset: .Sparkle)
        sparkle.scale *= 2.0
        sparkle.birthRate *= 2.0
        let emitter = ParticleEmitter(particle: sparkle)
        emitter.shape = kCAEmitterLayerRectangle
        layer.addParticleEmitter(emitter, forDuration: 3)
        afterDuration(1) {
            emitter.birthRate = 0
        }
    }
}