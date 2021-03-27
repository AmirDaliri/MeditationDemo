//
//  StoriesCellViewModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class StoriesCellViewModel: BaseVM {
    
    private var story: StoryModel
    
    init(story: StoryModel = StoryModel()) {
        self.story = story
    }
    
    var name: String {
        return story.name ?? ""
    }
    
    var category: String {
        return story.category ?? ""
    }
    
    var largeImageLink: String {
        return story.image?.large ?? ""
    }

    var smallImageLink: String {
        return story.image?.small ?? ""
    }
    
    var text: String {
        return story.text ?? ""
    }
    
    var date: String {
        return story.date?.timeStampToDate() ?? ""
    }
}
