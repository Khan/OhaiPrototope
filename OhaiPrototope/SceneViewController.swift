//
//  SceneViewController.swift
//  OhaiPrototope
//
//  Created by Marcos Ojeda on 1/10/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import UIKit
import Prototope

class SceneViewController: UIViewController {
	var backActionHandler: () -> Void = {}

	init(scene: Scene) {
		super.init(nibName: nil, bundle: nil)
		// set the view controller's view as the Prototope Root View
		Layer.setRoot(fromView: view)

		mainScene = scene.constructor()
		self.automaticallyAdjustsScrollViewInsets = false
	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has intentionally not been implemented")
	}

	// likely some form of 'scene'
	var mainScene: AnyObject!

    func handleKeyCommand(command: UIKeyCommand!) {
        switch command.input {
		case UIKeyInputEscape:
			backActionHandler()
        default:
            return
        }
    }

    // needed to let vc handle keypresses
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override var keyCommands: [AnyObject]? {
        get {
            let escape = UIKeyCommand(input: UIKeyInputEscape, modifierFlags: nil, action: "handleKeyCommand:")
            return [escape]
        }
    }

}

