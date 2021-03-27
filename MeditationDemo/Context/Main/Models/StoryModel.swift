//
//  StoryModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

// MARK: - Story
struct StoryModel: Codable {
    var name, category: String?
    var image: ImageModel?
    var date, text: String?
}

// MARK: Story convenience initializers and mutators

extension StoryModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StoryModel.self, from: data)
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
        name: String?? = nil,
        category: String?? = nil,
        image: ImageModel?? = nil,
        date: String?? = nil,
        text: String?? = nil
    ) -> StoryModel {
        return StoryModel(
            name: name ?? self.name,
            category: category ?? self.category,
            image: image ?? self.image,
            date: date ?? self.date,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
