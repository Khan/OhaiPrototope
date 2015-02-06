//
//  ThrowUnicorns.swift
//  OhaiPrototope
//
//  Because who doesn't want to throw Cats and also velocity
//  Copyright (c) 2015 May-Li Khoe. All rights reserved.
//

import Prototope

class ThrowCats {

    
    var catLayer: Layer!
    

    init(){
        Layer.root.backgroundColor = Color(hex: 0x32FFFB)
        makeCatLayer()
        
       
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
                var catVelocity = sequence.currentVelocityInLayer(self.catLayer.parent!)
                var catGoal =  Point(x:(self.catLayer.position.x + catVelocity.x), y: (self.catLayer.position.y + catVelocity.y))
                self.catLayer.animators.position.target = catGoal
                self.catLayer.animators.position.velocity = sequence.currentVelocityInLayer(self.catLayer.parent!)
                self.catLayer.animators.position.springBounciness = 0 //no springiness for this cat
                
            }
        })
        
        



        
    }
    





}
