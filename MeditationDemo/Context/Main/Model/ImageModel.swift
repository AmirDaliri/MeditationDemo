//
//  ImageModel.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

// MARK: - Image
struct ImageModel: Codable {
    var small, large: String?
}

// MARK: Image convenience initializers and mutators

extension ImageModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ImageModel.self, from: data)
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
        small: String?? = nil,
        large: String?? = nil
    ) -> ImageModel {
        return ImageModel(
            small: small ?? self.small,
            large: large ?? self.large
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
