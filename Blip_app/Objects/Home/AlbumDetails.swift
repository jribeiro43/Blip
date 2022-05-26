//
//  AlbumDetails.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit
import SwiftyJSON

class AlbumDetails: NSObject {
    var name: String = ""
    var artist: String = ""
    var imageDetails: [ImageDetails] = [ImageDetails]()
    
    init(json: JSON) {
        self.name = json["name"].exists() ? json["name"].stringValue : ""
        self.artist = json["artist"]["name"].exists() ? json["artist"]["name"].stringValue : ""
                
        let dataItems = json["image"]
        
        for (_, itemsJson): (String, JSON) in dataItems {
            let item: ImageDetails = ImageDetails(json: itemsJson)
            
            self.imageDetails.append(item)
        }
        

        super.init()
    }
}
