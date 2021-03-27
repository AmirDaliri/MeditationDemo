//
//  MainResponseModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

// MARK: - MainResponseModel
struct MainResponseModel: Codable {
    var isBannerEnabled: Bool?
    var meditations: [MeditationModel]?
    var stories: [StoryModel]?
}

// MARK: MainResponseModel convenience initializers and mutators

extension MainResponseModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MainResponseModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        isBannerEnabled: Bool?? = nil,
        meditations: [MeditationModel]?? = nil,
        stories: [StoryModel]?? = nil
    ) -> MainResponseModel {
        return MainResponseModel(
            isBannerEnabled: isBannerEnabled ?? self.isBannerEnabled,
            meditations: meditations ?? self.meditations,
            stories: stories ?? self.stories
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
