//
//  SceneListingViewController.swift
//  OhaiPrototope
//
//  Created by Andy Matuschak on 2/6/15.
//  Copyright (c) 2015 Marcos Ojeda. All rights reserved.
//

import UIKit

class SceneListingViewController: UITableViewController, UITableViewDelegate {
	private let dataSource: SceneListingDataSource
	private let sceneActivationHandler: Scene -> ()

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

@objc private class SceneListingDataSource: NSObject, UITableViewDataSource {
	var scenes: [Scene]
	init(scenes: [Scene]) {
		self.scenes = scenes
		super.init()
	}

	private func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return scenes.count
	}

	private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Scene", forIndexPath: indexPath) as UITableViewCell
		cell.textLabel!.text = scenes[indexPath.row].name
		return cell
	}
}