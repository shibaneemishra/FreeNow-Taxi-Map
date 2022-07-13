//
//  VehicleListViewModel.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import Foundation


@objc class VehicleListViewModel: NSObject {
    
    var reloadData:Bindable<Bool> = Bindable(false)
    var error:Bindable<Bool> = Bindable(false)
    var allVahicleList = [VachileList]()
    
    @objc func fetchVehicleDetails(latitude1:String,longitude1:String,latitude2:String,longitude2:String , isFromMapController:Bool){
        
        VehicleListRepository(.getVehicleList(latitude1, longitude1, latitude2, longitude2)).fetchVehicleDetails{ [self] response in
            allVahicleList = response?.poiList ?? [VachileList]()
            let arrConverted = convertArrayForMapController()
            if isFromMapController{
                DispatchQueue.main.async {
                    let controller: MapController = MapController()
                    controller.vehicleList(arrConverted)
                }
            }
            reloadData.value = true
            
        } _:{ error  in
            self.error.value = true
        }
        
    }
    
    
    
    
    func convertArrayForMapController() -> NSMutableArray{
        let arr:NSMutableArray = []
        for item in self.allVahicleList  {
            var model:Dictionary = Dictionary<String, Any>()
            model["id"] = item.id ?? ""
            model["latitude"] = item.coordinate?.latitude ?? ""
            model["longitude"] = item.coordinate?.longitude ?? ""
            model["state"] = item.state ?? ""
            model["type"] = item.type ?? ""
            model["heading"] = item.heading ?? ""
            arr.add(model)
        }
        return arr
    }
    
    
    
    
}
