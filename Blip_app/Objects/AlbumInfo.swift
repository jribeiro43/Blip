//
//  AlbumInfo.swift
//  Blip_app
//
//  Created by João Ribeiro on 25/05/2022.
//

import UIKit

import UIKit
import SwiftyJSON

class AlbumInfo: NSObject {
    
    var albumName: String = ""
    var albumImage: String = ""
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        self.albumName = json["albums"]["album"]["name"].exists() ? json["albums"]["album"]["name"].stringValue : ""
        
        for i in 0..<json["albums"]["album"]["image"].count {
            if json["albums"]["album"]["image"][i]["size"] == "extralarge" {
                self.albumName = json["albums"]["album"]["image"][i]["#text"].exists() ? json["albums"]["album"]["image"][i]["#text"].stringValue : ""
            }
        }
        
        super.init()
    }
}

