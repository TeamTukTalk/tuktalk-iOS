//
//  SignUpRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import Foundation

struct SignUpRequest: Codable {
    let subSpecialties: [String]
    let email: String
    let nickname: String
    let password: String
    let role: String
    let profileImageColor: String
    let firstLetter: String
    
    enum CodingKeys: String, CodingKey {
        case subSpecialties
        case email
        case nickname
        case password
        case role
        case profileImageColor
        case firstLetter
    }
    
    init(_ subSpecialties: [String], _ email: String, _ nickname: String, _ password: String, _ role: String, _ profileImageColor: String, _ firstLetter: String) {
        self.subSpecialties = subSpecialties
        self.email = email
        self.nickname = nickname
        self.password = password
        self.role = role
        self.profileImageColor = profileImageColor
        self.firstLetter = firstLetter
    }
}
