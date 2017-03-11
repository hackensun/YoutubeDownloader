//
//  MainViewController.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    Task().run(arguments: ["https://www.youtube.com/watch?v=EuzY9pGnAlQ"])
  }
}

