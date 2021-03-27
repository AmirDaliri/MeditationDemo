//
//  MainViewModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation
import UIKit

class MainViewModel: BaseVM {
    
    private var responseModel: MainResponseModel
    
    init(model: MainResponseModel = MainResponseModel()) {
        self.responseModel = model
    }
    
    func getMainData() {
        setState(.loading)
        Spinner.start()
        MainRequests.shared.getMainAppData { (response, err) in
            DispatchQueue.main.async {
                Spinner.stop()
                guard let model = response else {
                    self.handlePopup(error: err)
                    self.setState(.error(err))
                    return
                }
                self.responseModel = model
                self.setState(.success)
            }
        }
    }
    
    let insetForSectionAt = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16 )
    let itemSize = CGSize(width: 156, height: 220)
    var isBannerEnabled: Bool {
        return responseModel.isBannerEnabled ?? false
    }
    
    var storiesCount: Int {
        return responseModel.stories?.count ?? 0
    }
    
    var meditationsCount: Int {
        return responseModel.meditations?.count ?? 0
    }
    
    func storyAtIndex(_ index: Int) -> StoryModel {
        return responseModel.stories![index]
    }

    func meditationAtIndex(_ index: Int) -> MeditationModel {
        return responseModel.meditations![index]
    }
    
    func createStoriesCellViewModel(_ index: Int) -> StoriesCellViewModel {
        return StoriesCellViewModel(story: storyAtIndex(index))
    }

    func createMeditationsCellViewModel(_ index: Int) -> MeditationsCellViewModel {
        return MeditationsCellViewModel(meditation: meditationAtIndex(index))
    }
    
    // MARK: - collection View Method
    func numberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        if collectionView.tag == 0 {
            return storiesCount
        } else {
            return meditationsCount
        }
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell: StoriesCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? StoriesCollectionViewCell)!
            cell.viewModel = createStoriesCellViewModel(indexPath.row)
            return cell
        } else {
            let cell: MeditationsCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: MeditationsCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? MeditationsCollectionViewCell)!
            cell.viewModel = createMeditationsCellViewModel(indexPath.row)
            return cell
        }
    }
}
