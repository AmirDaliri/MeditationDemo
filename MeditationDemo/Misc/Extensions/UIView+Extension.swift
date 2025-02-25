//
//  UIView+Extension.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

extension UIView {
    
    func shakeView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func setshadowRadiusView(radius: CGFloat, shadowRadiuss: CGFloat, shadowheight: CGFloat, shadowOpacity: Float, shadowColor: UIColor) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: shadowheight)
        layer.shadowRadius = shadowRadiuss
        layer.shadowOpacity = shadowOpacity
    }
    
    internal func screenSize() ->(width : CGFloat,height : CGFloat){
        guard let window = UIApplication.shared.keyWindow else { return (0,0) }
        let width = window.frame.width
        let height = window.frame.height
        return (width ,height)
    }
}
