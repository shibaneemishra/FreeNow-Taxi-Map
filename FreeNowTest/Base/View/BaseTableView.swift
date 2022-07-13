//
//  Bindable.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//


import UIKit

@IBDesignable
class BaseTableView: UITableView{
    
    @IBInspectable
    var registerCell: String?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        if let registerCell1 = registerCell{
            registerCell(registerCell1)
        }
                
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        
    }
    
    func registerCell(_ nibName: String){
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func registerCells(_ cells: UITableViewCell.Type...){
        cells.forEach { (cellName) in
            let identifier = String(describing: cellName.self)
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueCell<T: UITableViewCell, U: Codable>(_ tableCell: T.Type, _ data: U,_ rowIndex:Int? = 0) -> T {
        let cell = dequeueReusableCell(withIdentifier: String(describing: tableCell.self)) as! T
        if let unwrappedCell = cell as? BaseTableCell{
            unwrappedCell.update(data: data,rowIndex: rowIndex)
        }
        return cell
    }
}
