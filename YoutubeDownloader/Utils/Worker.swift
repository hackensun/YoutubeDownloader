//
//  Worker.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Worker {

  func parse(link: String?, location: String?) -> [String] {
    guard let link = link, let location = location,
      !link.isEmpty,
      !location.isEmpty else {
      return []
    }

    let correctLocation = correct(location: location)
    
    return ["--output", "\(correctLocation)/%(title)s.%(ext)s", link]
  }

  func correct(location: String) -> String {
    guard location.hasSuffix("/") else {
      return location
    }

    return location.substring(to: location.index(before: location.endIndex))
  }
}
