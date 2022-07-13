//
//  ListCell.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import UIKit

class ListCell: BaseTableCell {

    @IBOutlet weak var lblType : UILabel!
    @IBOutlet weak var lblId : UILabel!
    @IBOutlet weak var lblLat : UILabel!
    @IBOutlet weak var lblLong : UILabel!
    @IBOutlet weak var lblState : UILabel!
    @IBOutlet weak var lblHeading : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func update<T>(data: T, rowIndex: Int? = 0){
        
        guard let data = data as? VachileList  else { return }
        self.lblId.text = data.id?.stringValue
        self.lblType.text = data.type
        self.lblLat.text = data.coordinate?.latitude?.stringValue
        self.lblLong.text = data.coordinate?.longitude?.stringValue
        self.lblState.text = data.state
        self.lblHeading.text = data.heading?.stringValue
        data.state == "ACTIVE" ? ( self.lblState.backgroundColor = .green) : ( self.lblState.backgroundColor = .red)
    }
    
}
