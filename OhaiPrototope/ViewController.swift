//
//  ViewController.swift
//  OhaiPrototope
//
//  Created by Marcos Ojeda on 1/10/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import UIKit
import Prototope

class ViewController: UIViewController {

    var mainScene: AnyObject! // likely some form of 'scene'
    
    var sceneNumber = 0
    
    // add any new scenes to this array in order to allow cycling through with double-double taps
    var sceneArray: [() -> AnyObject] = [ { TouchEvents() }, { ShadowLightsource() }, { TouchAnimators() }]

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the view controller's view as the Prototope Root View
        Layer.setRoot(fromView: view)
        
        Layer.root.gestures.append(TapGesture (numberOfTouchesRequired: 2, numberOfTapsRequired: 2) { _ in
            
            self.nextState()
            
            })

        // initialize the Touch Events demo
        mainScene = TouchEvents()

        // possibly initialize other ones instead
        // mainScene = ShadowLightsource()
        //mainScene = TouchAnimators()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func nextState() {

        if (sceneNumber >= sceneArray.count - 1) {
            sceneNumber = 0
        } else {
            sceneNumber++
        }
        
        Layer.root.removeAllSublayers()
        mainScene = sceneArray[sceneNumber]()
        

    }

}

