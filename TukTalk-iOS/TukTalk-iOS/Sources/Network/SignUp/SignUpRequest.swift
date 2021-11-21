//
//  SignUpRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import Foundation

struct SignUpRequest: Codable {
    let category: String
    let email: String
    let nickname: String
    let password: String
    let role: String
    let randomImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case email
        case nickname
        case password
        case role
        case randomImageURL
    }
    
    init(_ category: String, _ email: String, _ nickname: String, _ password: String, _ role: String, _ randomImageURL: String) {
        self.category = category
        self.email = email
        self.nickname = nickname
        self.password = password
        self.role = role
        self.randomImageURL = randomImageURL
    }
}
