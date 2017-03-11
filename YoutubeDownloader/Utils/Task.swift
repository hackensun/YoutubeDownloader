//
//  Task.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Task {

  func run(arguments: [String]) {
    let launchPath = Bundle.main.path(forResource: "youtube-dl", ofType: "")!
    run(launchPath: launchPath, arguments: arguments)
  }

  private func run(launchPath: String, arguments: [String]) {
    let process = Process()
    process.launchPath = launchPath
    process.arguments = arguments

    let stdOut = Pipe()
    process.standardOutput = stdOut
    let stdErr = Pipe()
    process.standardError = stdErr

    let handler =  { (file: FileHandle!) -> Void in
      let data = file.availableData
      guard let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return}

      print(output.components(separatedBy: "\n").first!)
    }

    stdErr.fileHandleForReading.readabilityHandler = handler
    stdOut.fileHandleForReading.readabilityHandler = handler

    process.terminationHandler = { (task: Process?) -> () in
      stdErr.fileHandleForReading.readabilityHandler = nil
      stdOut.fileHandleForReading.readabilityHandler = nil
    }

    process.launch()
    process.waitUntilExit()
  }
}
