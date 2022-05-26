//
//  AlbumInfo.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit
import SwiftyJSON

class AlbumInfo: NSObject {
    var albumName: String = ""
    var artistName: String = ""
    var tracksCount: Int = 0
    var publishDate: String = ""
    var listeners: String = ""

    init(json: JSON) {
        self.albumName = json["album"]["name"].exists() ? json["album"]["name"].stringValue : ""
        self.artistName = json["album"]["artist"].exists() ? json["album"]["artist"].stringValue : ""
        self.tracksCount = json["album"]["tracks"]["track"].exists() ? json["album"]["tracks"]["track"].count : 0
        self.publishDate = json["album"]["wiki"]["published"].exists() ? json["album"]["wiki"]["published"].stringValue : ""
        self.listeners = json["album"]["listeners"].exists() ? json["album"]["listeners"].stringValue : ""

        super.init()
    }
}
