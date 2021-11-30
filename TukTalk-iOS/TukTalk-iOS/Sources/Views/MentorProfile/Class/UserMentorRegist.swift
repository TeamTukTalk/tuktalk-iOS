//
//  UserMentorRegist.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

class UserMentorRegist {
    static let shared = UserMentorRegist()

    var nickname: String?
    var simpleIntroDuction: String?
    var detailedIntroduction: String?
    var specialty: String?
    var subSpecialties: [String] = []
    var companyName: String?
    var department: String?
    var position: String?
    var career: Career?
    var careerDescription: String?
    var companySize: String?
    var hashTags: [HashTag] = []

    private init() {}
}
