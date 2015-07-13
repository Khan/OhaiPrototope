//
//  ViewController.swift
//  OhaiPrototopeOSX
//
//  Created by Jason Brennan on 2015-07-12.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Cocoa
import PrototopeOSX

class ViewController: NSViewController {
	
	var environment: Environment!
	var layer: Layer!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
//		Speech.say("oh hi", rate: 200)
		self.view.wantsLayer = true
		self.environment = Environment.defaultEnvironmentWithRootView(self.view)
		Environment.currentEnvironment = self.environment
		
		self.layer = Layer(parent: nil, name: "My layer", viewClass: nil)
		self.layer.size = Size(width: 200, height: 250)
		self.layer.backgroundColor = Color.purple
		self.layer.border = Border(color: Color.orange, width: 5)
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

