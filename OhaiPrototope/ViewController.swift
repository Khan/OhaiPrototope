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

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the view controller's view as the Prototope Root View
        Layer.setRoot(fromView: view)

        // initialize the main scene
        mainScene = MainScene()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

