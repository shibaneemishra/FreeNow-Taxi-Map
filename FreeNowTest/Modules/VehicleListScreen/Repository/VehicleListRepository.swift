//
//  VehicleListRepository.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import UIKit

enum VehicleListService{
    case getVehicleList(String,String,String,String)
}

class VehicleListRepository {
    
    var httpClient =  HTTPClient()
    var serviceType: VehicleListService = .getVehicleList("","","","")
    typealias StringResponse = (String?) -> Void
    
    init(_ service: VehicleListService) {
        self.serviceType = service
    }
    
    // fetchVehicleDetails from server
    
func fetchVehicleDetails( _ onResponse : @escaping ((VehicleModelResponse?) -> Void), _ onFailure : @escaping StringResponse){
        
        let request = self.request()
        let dataTask = URLSession.shared.dataTask(with: request){
            data,response,error in
            print("anything")
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print(jsonResult)
                    let jsonResponse = try JSONDecoder().decode(VehicleModelResponse.self, from: data ?? Data())
                    print("response\(jsonResult)")
                    onResponse(jsonResponse)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
}

extension VehicleListRepository:RequestProtocol{
    var URL: String {
        switch serviceType{
        case .getVehicleList:
            return NetworkConstants.API.allVehicleList
        }
    }
    
    
    
    var httpMethod: HTTPMethod {
        switch serviceType{
        case .getVehicleList:
            return .GET
            
        }
    }
    
    var httpBody: Data? {
        return nil
    }
    
    var queryParams: [String : String]? {
        switch serviceType{
        case .getVehicleList(let lat1, let long1, let lat2, let long2):
            return   [ "p1Lat" : lat1,
                       "p1Lon" : long1,
                       "p2Lat" : lat2,
                       "p2Lon" : long2]
            
        }
        
    }
}


