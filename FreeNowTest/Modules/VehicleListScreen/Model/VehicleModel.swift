//
//  VehicleModel.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import Foundation

 class VehicleModelResponse : Codable{
    let poiList : [VachileList]?
    
    enum CodingKeys: String, CodingKey {
        case poiList = "poiList"
    }

}

@objc class VachileList : NSObject, Codable {
    
    let id : Double?
    let coordinate : Coordinate?
    let state : String?
    let type : String?
    let heading : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case coordinate = "coordinate"
        case state = "state"
        case type = "type"
        case heading = "heading"
    }
}
class Coordinate : Codable {
    
    let latitude : Double?
    let longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

