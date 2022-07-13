//
//  BaseTableCell.swift
//  Loyalty
//
//  Created by Shibanee Mishra on 03/02/22.
//


import UIKit

class BaseTableCell: UITableViewCell{
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update<T: Codable>(data: T,rowIndex:Int? = 0){}
}
