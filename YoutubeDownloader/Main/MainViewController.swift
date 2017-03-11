//
//  MainViewController.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

  var task: Task?

  @IBOutlet var linkTextView: NSTextView!
  @IBOutlet weak var locationTextField: NSTextField!
  @IBOutlet var consoleTextView: NSTextView!
  @IBOutlet weak var startButton: NSButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  // MARK: - Setup

  func setup() {
    locationTextField.stringValue = Config.shared.location
  }

  // MARK: - Action

  @IBAction func startButtonTouched(_ sender: NSButton) {
    if task == nil {
      start()
    } else {
      stop()
    }
  }

  func start() {
    startButton.title = "Stop"
    consoleTextView.string = ""
    task = Task()
    task?.delegate = self
    task?.run(arguments: ["https://www.youtube.com/watch?v=EuzY9pGnAlQ"])
  }

  func stop() {
    task?.stop()
  }
}

extension MainViewController: TaskDelegate {

  func task(task: Task, didOutput string: String) {
    let attributedString = NSAttributedString(string: string)
    consoleTextView.textStorage?.append(attributedString)
  }

  func taskDidComplete(task: Task) {
    self.task = nil
    startButton.title = "Start"
  }
}
