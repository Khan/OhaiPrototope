//
//  MainScene.swift
//  OhaiPrototope
//
//  Created by __YOUR_NAME_HERE__ on __DATE__
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import Prototope

class MainScene {
    
    var demoLayer: Layer!
    
    init(){
        Layer.root.backgroundColor = Color(white: 0.95, alpha: 1)
        makeDemoLayer()
    }
    
    func makeDemoLayer(){
        demoLayer = Layer(parent: Layer.root)
        demoLayer.width = 700
        demoLayer.height = 700
        demoLayer.backgroundColor = Color(white: 1, alpha: 1)
        demoLayer.x = 384
        demoLayer.y = 512
    }
    
}