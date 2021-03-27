//
//  MainVC.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class MainVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            setCollectionViewDataSourceDelegate(self)
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
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate Datasource

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItemAt(collectionView, indexPath: indexPath)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width:collectionView.frame.size.width, height:100)
//    }

    
    // MARK: - CollectionView Parameters Configure
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D) {
        collectionView.register(cellClass: StoriesCollectionViewCell.self)
        collectionView.register(cellClass: BannerCollectionViewCell.self)
        collectionView.register(cellClass: MeditationsCollectionViewCell.self)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
    }
}
