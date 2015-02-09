//
//  VideoScene.swift
//  OhaiPrototope
//
//  Created by Jason Brennan on 2015-02-09.
//  Copyright (c) 2015 Prototope Research Facility. All rights reserved.
//

import Prototope

/** Plays a great video. */
class VideoScene {
	let video: Video
	let videoLayer: VideoLayer
	
	init() {
		Layer.root.backgroundColor = Color(hex: 0xFFF5D9)
		self.video = Video(name: "jeff.mp4")
		
		self.videoLayer = VideoLayer(parent: Layer.root, video: self.video)
		
		self.videoLayer.size = Size(width: 400, height: 300)
		self.videoLayer.x = 200
		self.videoLayer.y = 200
		
		self.videoLayer.play()
	}
	
	
	deinit {
		// Unless you want a Goldblum ghost.
		self.videoLayer.pause()
	}
}