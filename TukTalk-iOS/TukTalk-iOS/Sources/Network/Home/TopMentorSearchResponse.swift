//
//  TopMentorSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct TopMentorSearchResponseElement: Codable {
    let id: Int
    let nickname, companyName, department: String
    let profileImageURL: JSONNull?
    let profileImageColor, firstLetter: String
    let hashTags: [HashTag]

    enum CodingKeys: String, CodingKey {
        case id, nickname, companyName, department
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, hashTags
    }
}

// MARK: - HashTag
struct HashTag: Codable {
    let hashTag: String
}

typealias TopMentorSearchResponse = [TopMentorSearchResponseElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
