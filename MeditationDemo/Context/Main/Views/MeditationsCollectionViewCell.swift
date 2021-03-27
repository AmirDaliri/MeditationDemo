//
//  MeditationsCollectionViewCell.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class MeditationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var meditationImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        }
    }
        
    var viewModel: MeditationsCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title ?? "-"
            subtitleLabel.text = viewModel?.subtitle ?? "-"
            meditationImageView.setImage(urlString: viewModel?.smallImageLink)
        }
    }

}
