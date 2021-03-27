//
//  MeditationsCellViewModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

class MeditationsCellViewModel: BaseVM {
    
    private var meditation: MeditationModel
    
    init(meditation: MeditationModel = MeditationModel()) {
        self.meditation = meditation
    }
    
    var title: String {
        return meditation.title ?? ""
    }
    
    var subtitle: String {
        return meditation.subtitle ?? ""
    }
    
    var largeImageLink: String {
        return meditation.image?.large ?? ""
    }

    var smallImageLink: String {
        return meditation.image?.small ?? ""
    }
    
    var content: String {
        return meditation.content ?? ""
    }
    
    var releaseDate: String {
        return meditation.releaseDate?.timeStampToDate() ?? ""
    }
}
