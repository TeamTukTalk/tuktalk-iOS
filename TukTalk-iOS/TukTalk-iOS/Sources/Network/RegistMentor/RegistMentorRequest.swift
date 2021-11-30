//
//  RegistMentorRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

struct RegistMentorRequest: Codable {
    let nickname: String
    let simpleIntroDuction: String
    let detailedIntroduction: String
    let specialty: String
    let subSpecialties: [String]
    let companyName: String
    let department: String
    let position: String
    let career: Career
    let careerDescription: String
    let companySize: String
    let hashTags: HashTag
}

// MARK: - Career
struct Career: Codable {
    let months, years: Int
}
