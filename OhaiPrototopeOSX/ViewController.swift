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

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		Speech.say("oh hi", rate: 200)
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

