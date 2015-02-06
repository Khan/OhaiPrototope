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
        
        let catUpdateHandler: () -> Void = {
            if (self.catLayer.position.x > 0 && self.catLayer.position.x < self.catLayer.parent!.width &&
                self.catLayer.position.y > 0 && self.catLayer.position.y < self.catLayer.parent!.height) {
                    return;
            }
            self.catLayer.animators.position.stop()
            self.catLayer.position = Point(x: 400, y: 512)
        }
        
        catLayer.gestures.append(PanGesture(cancelsTouchesInLayer: false) { phase, sequence in
            switch phase {
            case .Began:
                self.catLayer.animators.position.stop()
            case .Changed:
                self.catLayer.position += sequence.currentSample.locationInLayer(self.catLayer.parent!) - sequence.previousSample!.locationInLayer(self.catLayer.parent!)
            case .Ended, .Cancelled:
                var catVelocity = sequence.currentVelocityInLayer(self.catLayer.parent!)
                let animation = DecayAnimation(velocity: catVelocity)
                self.catLayer.animators.position.animationKind = animation
                self.catLayer.animators.position.applyHandler = catUpdateHandler
            }
        })
        
        



        
    }
    





}
