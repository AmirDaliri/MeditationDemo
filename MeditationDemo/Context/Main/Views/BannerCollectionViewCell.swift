//
//  BannerCollectionViewCell.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var bannerIconImageView: UIImageView! {
        didSet {
            bannerIconImageView.image = #imageLiteral(resourceName: "ic_night")
        }
    }
    @IBOutlet private weak var bannerStatusMessageLabel: UILabel! {
        didSet {
            bannerStatusMessageLabel.text = "Look. Pretty, isn’t it?\nPerfectly balanced. As all things should be."
        }
    }
}
