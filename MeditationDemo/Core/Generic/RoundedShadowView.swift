//
//  RoundedShadowView.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

class RoundedShadowView: BaseView {

    // MARK: - Override Functions
    override func configureUI() {
        self.setshadowRadiusView(radius: 12, shadowRadiuss: 1, shadowheight: 5, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08))
    }
}
