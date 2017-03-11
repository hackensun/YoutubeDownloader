//
//  Task.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

protocol TaskDelegate: class {
  func task(task: Task, didOutput string: String)
  func taskDidComplete(task: Task)
}

class Task {

  weak var delegate: TaskDelegate?
  let process = Process()

  func run(arguments: [String]) {
    DispatchQueue.background.async {
      let launchPath = Bundle.main.path(forResource: "youtube-dl", ofType: "")!
      self.run(launchPath: launchPath, arguments: arguments)
    }
  }

  func stop() {
    DispatchQueue.background.async {
      if self.process.isRunning {
        self.process.terminate()
      }
    }
  }

  // MARK: - Helper

  private func run(launchPath: String, arguments: [String]) {
    let process = Process()
    process.launchPath = launchPath
    process.arguments = arguments

    let stdOut = Pipe()
    process.standardOutput = stdOut
    let stdErr = Pipe()
    process.standardError = stdErr

    let handler =  { [weak self] (file: FileHandle!) -> Void in
      let data = file.availableData
      guard let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
        return
      }

      guard let strongSelf = self,
        let string = output.components(separatedBy: "\n").first else {
        return
      }

      DispatchQueue.main.async {
        strongSelf.delegate?.task(task: strongSelf, didOutput: string)
      }
    }

    stdErr.fileHandleForReading.readabilityHandler = handler
    stdOut.fileHandleForReading.readabilityHandler = handler

    process.terminationHandler = { [weak self] (task: Process?) -> () in
      stdErr.fileHandleForReading.readabilityHandler = nil
      stdOut.fileHandleForReading.readabilityHandler = nil

      guard let strongSelf = self else {
        return
      }

      DispatchQueue.main.async {
        strongSelf.delegate?.taskDidComplete(task: strongSelf)
      }
    }

    process.launch()
    process.waitUntilExit()
  }
}
