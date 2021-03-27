//
//  MeditationModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

// MARK: - Meditation
struct MeditationModel: Codable {
    var title, subtitle: String?
    var image: ImageModel?
    var releaseDate, content: String?
}

// MARK: Meditation convenience initializers and mutators

extension MeditationModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MeditationModel.self, from: data)
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
        title: String?? = nil,
        subtitle: String?? = nil,
        image: ImageModel?? = nil,
        releaseDate: String?? = nil,
        content: String?? = nil
    ) -> MeditationModel {
        return MeditationModel(
            title: title ?? self.title,
            subtitle: subtitle ?? self.subtitle,
            image: image ?? self.image,
            releaseDate: releaseDate ?? self.releaseDate,
            content: content ?? self.content
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
