//
//  CALayer+Extension.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

extension CALayer {
    
    func drawShadow( color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0,  y: CGFloat = 2,blur:CGFloat = 4, spread: CGFloat = 0){
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
            return
        }
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        shadowPath = UIBezierPath(rect: rect).cgPath
    }
}
