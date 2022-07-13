//
//  CustomView.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 13/07/22.
//

import Foundation
import UIKit


@IBDesignable
class GradientView: UIView{

    @IBInspectable
    var firstColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable
    var secondColor: UIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    @IBInspectable
    var isGradient: Bool = true

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        if isGradient{
            applyGradient(colours: [firstColor, secondColor])
        }
    }
}
