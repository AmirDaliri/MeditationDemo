//
//  DetailViewModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation
import UIKit

class DetailViewModel: BaseVM {
    
    private var story: StoryModel
    private var meditation: MeditationModel
    
    init(meditation: MeditationModel = MeditationModel(), story: StoryModel = StoryModel()) {
        self.meditation = meditation
        self.story = story
    }
    
    func bindData(story: StoryModel, meditation: MeditationModel, isStory: Bool) {
        self.story = story
        self.meditation = meditation
        self.isStory = isStory
        self.setState(.success)
    }
    
    var isStory: Bool = false
    
    var title: String {
        if isStory {
            return story.name ?? ""
        } else {
            return meditation.title ?? ""
        }
    }
    
    var descriptionValue: String {
        if isStory {
            return story.text ?? ""
        } else {
            return meditation.content ?? ""
        }
    }
    
    var imageLink: String {
        if isStory {
            return story.image?.large ?? ""
        } else {
            return meditation.image?.large ?? ""
        }
    }
    
    var date: String {
        if isStory {
            return story.date?.timeStampToDate() ?? ""
        } else {
            return meditation.releaseDate?.timeStampToDate() ?? ""
        }
    }
}
