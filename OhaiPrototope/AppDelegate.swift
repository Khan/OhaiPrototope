//
//  AppDelegate.swift
//  OhaiPrototope
//
//  Created by Marcos Ojeda on 1/10/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow!
	var navigationController: UINavigationController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window.makeKeyAndVisible()

		let sceneListingViewController = SceneListingViewController(
			scenes: Scene.sceneIndex,
			sceneActivationHandler: { [unowned self] in self.activateScene($0) }
		)
		sceneListingViewController.title = "Prototypes"
		navigationController = UINavigationController(rootViewController: sceneListingViewController)
		navigationController.interactivePopGestureRecognizer.enabled = false
		window.rootViewController = navigationController

        return true
    }

	private func activateScene(scene: Scene) {
		let sceneViewController = SceneViewController(scene: scene)
		sceneViewController.backActionHandler = {
			self.navigationController.setNavigationBarHidden(false, animated: true)
			self.navigationController.popViewControllerAnimated(true)
		}
		navigationController.setNavigationBarHidden(true, animated: true)
		navigationController.pushViewController(sceneViewController, animated: true)

		if !NSUserDefaults.standardUserDefaults().boolForKey("hasSeenNavigationWarning") {
			UIAlertView(title: "Navigation Tutorial", message: "Type Escape or press the Volume Up button to navigate back.\n\nYou won't see this message again.", delegate: nil, cancelButtonTitle: "OK").show()
			NSUserDefaults.standardUserDefaults().setBool(true, forKey:"hasSeenNavigationWarning")
		}
	}

	
}

