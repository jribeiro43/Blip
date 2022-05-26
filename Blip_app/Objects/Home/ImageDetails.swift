//
//  ImageDetails.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit

import UIKit
import SwiftyJSON

class ImageDetails: NSObject {
    var url: String = ""
    var size: String = ""
    
    init(json: JSON) {
        self.url = json["#text"].exists() ? json["#text"].stringValue : ""
        self.size = json["size"].exists() ? json["size"].stringValue : ""

        super.init()
    }
}
