//
//  MainResponseModelTest.swift
//  MeditationDemoTests
//
//  Created by Amir Daliri on 3/27/21.
//

import XCTest
@testable import MeditationDemo

class MainResponseModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataModelParsedCorrectly() {
        var model = MainResponseModel()
        let imageModel = ImageModel(small: nil, large: "https://via.placeholder.com/600/DFFF00")
        let meditationModel = MeditationModel(title: "Meditation_1", subtitle: "Meditation_1_subtitle", image: imageModel, releaseDate: "1614246146", content: "Lorem Ipsum")
        let storyModel = StoryModel(name: "Story_1", category: "Category_1", image: imageModel, date: "1614246146", text: "Lorem Ipsum")
        model = MainResponseModel(isBannerEnabled: true, meditations: [meditationModel], stories: [storyModel])
        XCTAssertNotEqual(model.stories?.count, 0)
        XCTAssertEqual(model.meditations?.first?.title, "Meditation_1")
        XCTAssertEqual(model.stories?.first?.name, "Story_1")
        XCTAssertEqual(model.isBannerEnabled, true)
        XCTAssertNotEqual(model.stories?.first?.image?.large, nil)
        XCTAssertEqual(model.stories?.first?.image?.small, nil)
    }


}
