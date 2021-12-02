//
//  RegistMentorRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

struct RegistMentorRequest: Codable {
    let nickname, simpleIntroduction, detailedIntroduction, specialty: String
    let subSpecialties: [String]
    let companyName, department, position: String
    let career: Career
    let careerDescription, companySize: String
    let hashTags: [HashTag]
}

// MARK: - Career
struct Career: Codable {
    let months, years: Int
}
