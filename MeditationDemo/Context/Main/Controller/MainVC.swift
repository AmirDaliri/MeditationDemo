//
//  MainVC.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class MainVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet private weak var storyCollectionView: UICollectionView! {
        didSet {
            storyCollectionView.tag = 0
            storyCollectionView.register(cellClass: StoriesCollectionViewCell.self)
            setCollectionViewDataSourceDelegate(storyCollectionView, self)
        }
    }
    @IBOutlet private weak var bannerContainerView: UIView!
    @IBOutlet private weak var bannerView: UIView! {
        didSet {
            bannerView.layer.cornerRadius = 4
            bannerView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var meditationsCollectionView: UICollectionView! {
        didSet {
            meditationsCollectionView.tag = 1
            meditationsCollectionView.register(cellClass: MeditationsCollectionViewCell.self)
            setCollectionViewDataSourceDelegate(meditationsCollectionView, self)
        }
    }
    
    // MARK: - Properties
    private var viewModel = MainViewModel()
    private var disposal = Disposal()

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        isNavigationBarHidden = true
        bindUI()
        viewModel.getMainData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        bannerContainerView.isHidden = !viewModel.isBannerEnabled
        storyCollectionView.reloadData()
        meditationsCollectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate Datasource

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(collectionView, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItemAt(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.itemSize
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    
    // MARK: - CollectionView Parameters Configure
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ collectionView: UICollectionView, _ dataSourceDelegate: D) {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
    }
}
