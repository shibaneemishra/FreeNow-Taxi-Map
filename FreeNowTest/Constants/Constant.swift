//
//  Constant.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import Foundation

class NetworkConstants{
    struct Service{
        static let timeInterval = 120.0
        
    }
    struct API {
        static let allVehicleList = "https://api.mytaxi.com/poiservice/poi/v1"
    }
    struct APIConstant {
        
        static let Lattitude_1 = "53.694865"
        static let Longitude_1 = "9.757589"
        static let Lattitude_2 = "53.394655"
        static let Longitude_2 = "10.099891"

    }
}

extension Double {
    var stringValue:String {
        let value: String = String(format: "%.2f", self)
        return value
//        return "\(self)"
    }
}
