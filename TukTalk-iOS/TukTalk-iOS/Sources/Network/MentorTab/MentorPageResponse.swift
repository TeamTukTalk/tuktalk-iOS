//
//  MentorPageResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//
import Foundation

struct MentorPageResponse: Codable {
    let mentorID: Int
    let profileImageURL, profileImageColor, firstLetter, nickname: String
    let simpleIntroduction, detailedIntroduction, companyName, specialty: String
    let subSpecialties: [SubSpecialty]
    let position: String
    let career: Career
    let careerDescription: String
    let hashTags: [HashTag]
    let addedToWishList: Bool

    enum CodingKeys: String, CodingKey {
        case mentorID = "mentorId"
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, nickname, simpleIntroduction, detailedIntroduction, companyName, specialty, subSpecialties, position, career, careerDescription, hashTags, addedToWishList
    }
}

// MARK: - SubSpecialty
struct SubSpecialty: Codable {
    let value: String
}
