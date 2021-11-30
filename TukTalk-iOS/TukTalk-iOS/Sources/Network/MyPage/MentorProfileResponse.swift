//
//  MentorProfileRequset.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Foundation

struct MentorProfileResponse: Codable {
    let profileImageURL, profileImageColor, firstLetter, nickname: String
    let simpleIntroduction, detailedIntroduction, companyName, specialty: String
    let subSpecialties: [SubSpecialty]
    let position: String
    let career: Career
    let careerDescription: String
    let hashTags: [HashTag]

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, nickname, simpleIntroduction, detailedIntroduction, companyName, specialty, subSpecialties, position, career, careerDescription, hashTags
    }
}

// MARK: - SubSpecialty
struct SubSpecialty: Codable {
    let value: String
}
