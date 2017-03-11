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
    
    return ["--output", "\"\(location)/%(title)s.%(ext)s\"", link]
  }
}
