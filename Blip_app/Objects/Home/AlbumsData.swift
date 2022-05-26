//
//  AlbumsData.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit
import SwiftyJSON

class AlbumsData: NSObject {
    var albumDetails: [AlbumDetails] = [AlbumDetails]()
    
    init(json: JSON) {
        
        let response = json["album"]
        
        for i in 0..<response.count {
            let dataAvailable = response[i]
            
//            for(_, availableJson): (String, JSON) in dataAvailable {
                let availableData: AlbumDetails = AlbumDetails(json: dataAvailable)
                self.albumDetails.append(availableData)
//            }
        }
        
        super.init()
    }
}
