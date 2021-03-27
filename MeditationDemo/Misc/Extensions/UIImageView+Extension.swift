//
//  UIImageView+Extension.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            completionHandler: nil)
    }
}
