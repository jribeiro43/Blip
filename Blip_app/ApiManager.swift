//
//  ApiManager.swift
//  Blip_app
//
//  Created by João Ribeiro on 25/05/2022.
//

import UIKit

class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
    let baseURL: String

    override init() {
        self.baseURL = "https://ws.audioscrobbler.com/2.0/"
        
        super.init()
    }


}
