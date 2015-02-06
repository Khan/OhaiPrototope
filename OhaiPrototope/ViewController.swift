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
    var sceneArray: [() -> AnyObject] = [ { TouchEvents() }, { ShadowLightsource() }, { TouchAnimators() }, { TouchUnicorns() }, { RotationGesturePlaypen() }, { ThrowCats() }]

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the view controller's view as the Prototope Root View
        Layer.setRoot(fromView: view)

        Layer.root.gestures.append(TapGesture (numberOfTouchesRequired: 2, numberOfTapsRequired: 2) { _ in

            self.jumpScene(1)

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

    // advance or go back to scene in sceneArray by relative
    // amount, not index
    func jumpScene(amount: Int) {
        sceneNumber += amount + sceneArray.count;
        sceneNumber %= sceneArray.count;

        Layer.root.removeAllSublayers()
        mainScene = sceneArray[sceneNumber]()
    }


    func handleKeyCommand(command: UIKeyCommand!) {
        switch command.input {
        case "j":
            jumpScene(1)
        case "k":
            jumpScene(-1)
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
            let prev = UIKeyCommand(input: "k", modifierFlags: nil, action: "handleKeyCommand:")
            let next = UIKeyCommand(input: "j", modifierFlags: nil, action: "handleKeyCommand:")
            return [prev, next]
        }
    }

}

