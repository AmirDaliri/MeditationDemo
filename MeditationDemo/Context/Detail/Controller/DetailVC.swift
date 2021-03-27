//
//  DetailVC.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class DetailVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.backgroundColor = UIColor.white.withAlphaComponent(0.15)
            dateLabel.textColor = UIColor.white.withAlphaComponent(0.7)
            dateLabel.layer.cornerRadius = 16
            dateLabel.layer.masksToBounds = true
        }
    }
    
    
    // MARK: - Properties
    private var viewModel = DetailViewModel()
    private var disposal = Disposal()

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        bindUI()
        if let story = self.data as? StoryModel {
            viewModel.bindData(story: story, meditation: MeditationModel(), isStory: true)
        } else if let meditation = self.data as? MeditationModel {
            viewModel.bindData(story: StoryModel(), meditation: meditation, isStory: false)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        self.isNavigationBarHidden = false
    }
    
    // MARK: - Private Method
    private func bindUI() {
        viewModel.state.observe { [weak self] (state) in
            guard let self = self else { return }
            switch state {
            case .success:
                self.updateUI()
            case .error(let err):
                self.handleAlertView(title: nil, message: err ?? "")
            default:
                break
            }
        }.add(to: &disposal)
    }
    
    private func updateUI() {
        backgroundImageView.setImage(urlString: viewModel.imageLink, cornerRadius: 0)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptionValue
        dateLabel.text = viewModel.date
    }
}
