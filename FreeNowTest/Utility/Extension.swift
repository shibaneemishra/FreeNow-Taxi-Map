//
//  Extension.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 13/07/22.
//

import Foundation
var activityView: UIActivityIndicatorView?


extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        self.layer.sublayers?.forEach({($0 as? CAGradientLayer)?.removeFromSuperlayer()})
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
}

extension UIViewController {
 
func showActivityIndicator() {
    activityView = UIActivityIndicatorView(style: .large)
    activityView?.center = self.view.center
    self.view.addSubview(activityView!)
    activityView?.startAnimating()
}

func hideActivityIndicator(){
    if (activityView != nil){
        activityView?.stopAnimating()
    }
}
}
