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
    let mentor: Mentor
    let rating: Int
    let reviewDescription: String
    let mentee: Mentee
}

// MARK: - Mentee
struct Mentee: Codable {
    let nickname: String
}

// MARK: - Mentor
struct Mentor: Codable {
    let nickname, companyName, subSpecialty: String
}
