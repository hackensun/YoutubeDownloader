//
//  DispatchQueue+Extensions.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

extension DispatchQueue {

  static var background: DispatchQueue {
    return DispatchQueue.global(qos: .default)
  }
}
