//
//  GeneralAlbum.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit
import SwiftyJSON

class GeneralAlbum: NSObject {
    var albums: [AlbumsData] = [AlbumsData]()
    
    override init() {
    }
    
    init(json: JSON = "{}") {
        
        let dataAvailable = json["albums"].rawValue

//        for(_, availableJson): (String, JSON) in dataAvailable {
        let availableData: AlbumsData = AlbumsData(json: JSON(rawValue: dataAvailable)!)
            
        self.albums.append(availableData)
//        }
        
        super.init()
    }
    
}
