//
//  WebApiManager.swift
//  Blip_app
//
//  Created by João Ribeiro on 25/05/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebApiManager: NSObject {
    static let sharedInstance = WebApiManager()
   
    let baseURL: String
    
    override init() {
        self.baseURL = "https://ws.audioscrobbler.com/2.0/?"
        super.init()
    }
    
    // MARK: Api Call Funcs
    
    func getApiData(limit: Int, method: String, tag: String, onCompletion: @escaping (AlbumInfo) -> Void) {
        let route = baseURL + "/shopping-carts/guest"
       
        let headers: [String: String] = ["":""]
        
        var parameters: [String: Any] = ["":""]
        parameters = [
            "api_key": "340f294fae3384308e5cc06039786807",
            "format": "json",
            "tag": tag,
            "method": method,
            "limit": limit
        ]
        
        Alamofire.request(route, method: Alamofire.HTTPMethod.post , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response)
                
                var result = AlbumInfo(json: ["":""])
                
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        result = AlbumInfo(json: JSON(json))
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                DispatchQueue.main.async(execute: {
                    onCompletion(result)
                })
        }
        
    }

}
