//
//  SceneListingViewController.swift
//  OhaiPrototope
//
//  Created by Andy Matuschak on 2/6/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import UIKit

class SceneListingViewController: UITableViewController {
	private let dataSource: SceneListingDataSource
	private var sceneActivationHandler: Scene -> ()

	init(scenes: [Scene], sceneActivationHandler: Scene -> ()) {
		dataSource = SceneListingDataSource(scenes: scenes)
		self.sceneActivationHandler = sceneActivationHandler
		super.init(nibName: nil, bundle: nil)
		tableView.dataSource = dataSource
		tableView.delegate = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Scene")
	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has intentionally not been implemented")
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		sceneActivationHandler(dataSource.scenes[indexPath.row])
	}
}

private class SceneListingDataSource: NSObject, UITableViewDataSource {
	var scenes: [Scene]
	init(scenes: [Scene]) {
		self.scenes = scenes
		super.init()
	}
	@objc private func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return scenes.count
	}
	@objc private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	@objc private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Scene", forIndexPath: indexPath) 
		cell.textLabel!.text = scenes[indexPath.row].name
		return cell
	}
}
