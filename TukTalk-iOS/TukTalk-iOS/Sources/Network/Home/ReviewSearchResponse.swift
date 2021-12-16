//
//  ReviewSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

// MARK: - ReviewSearchResponse
struct ReviewSearchResponse: Codable {
    let reviews: [Review]
}

// MARK: - Review
struct Review: Codable {
    let reviewID, mentorID: Int
    let profileImageURL, profileImageColor, firstLetter: String
    let mentor: Mentor
    let rating: Int
    let reviewDescription: String
    let mentee: Mentee
    let portfolioViewedDateTime, reviewCreatedDateTime: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case mentorID = "mentorId"
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, mentor, rating
        case reviewDescription = "description"
        case mentee, portfolioViewedDateTime, reviewCreatedDateTime
    }
}

// MARK: - Mentee
struct Mentee: Codable {
    let nickname: String
}

// MARK: - Mentor
struct Mentor: Codable {
    let nickname, companyName, subSpecialty: String
}
