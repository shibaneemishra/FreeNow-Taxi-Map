//
//  VehicleListController.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import UIKit

class VehicleListController: UIViewController {
    
    @IBOutlet weak var tableView: BaseTableView!
    var viewModel = VehicleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialization()
        addListener()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
        viewModel.fetchVehicleDetails(latitude1:NetworkConstants.APIConstant.Lattitude_1 , longitude1: NetworkConstants.APIConstant.Longitude_1, latitude2: NetworkConstants.APIConstant.Lattitude_2, longitude2: NetworkConstants.APIConstant.Longitude_2, isFromMapController: false)
    }
    
    func intialization(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(ListCell.self)
        tableView.reloadData()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    func addListener() {
        viewModel.reloadData.bind(listener: { _ in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.tableView.reloadData()
            }
        })
        viewModel.error.bind(listener: {_ in
            DispatchQueue.main.async {
                self.hideActivityIndicator()}
        })
        
    }
    
    @IBAction func action_btnMap(_ sender:UIButton){
        
        let controller: MapController = MapController()
        let arr = viewModel.convertArrayForMapController()
        controller.arrVachile = arr
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
extension VehicleListController {
    static func getInstance() -> VehicleListController {
        let controller = VehicleListController()
        return controller
    }
}


//MARK: TableView

extension VehicleListController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allVahicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueCell(ListCell.self,viewModel.allVahicleList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
