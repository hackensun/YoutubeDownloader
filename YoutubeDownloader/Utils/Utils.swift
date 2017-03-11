//
//  Utils.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

struct Utils {

  static func alert(title: String, message: String) {
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = message
    alert.addButton(withTitle: "OK")

    alert.beginSheetModal(for: NSApplication.shared().keyWindow!, completionHandler: nil)
  }
}
