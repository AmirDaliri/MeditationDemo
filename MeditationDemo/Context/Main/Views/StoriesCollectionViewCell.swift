//
//  StoriesCollectionViewCell.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var storyImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel! {
        didSet {
            categoryLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        }
    }
        
    var viewModel: StoriesCellViewModel? {
        didSet {
            nameLabel.text = viewModel?.name ?? "-"
            categoryLabel.text = viewModel?.name ?? "-"
            storyImageView.setImage(urlString: viewModel?.smallImageLink)
        }
    }
}
