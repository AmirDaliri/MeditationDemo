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
    func numberOfItemsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return storiesCount
        case 1:
            return isBannerEnabled ? 1:0
        case 2:
            return meditationsCount
        default:
            return 0
        }
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: StoriesCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? StoriesCollectionViewCell)!
            cell.viewModel = createStoriesCellViewModel(indexPath.row)
            cell.backgroundColor = .red
            return cell
        case 1:
            let cell: BannerCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? BannerCollectionViewCell)!
            cell.backgroundColor = .blue
            return cell
        case 2:
            let cell: MeditationsCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: MeditationsCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? MeditationsCollectionViewCell)!
            cell.viewModel = createMeditationsCellViewModel(indexPath.row)
            cell.backgroundColor = .yellow
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
