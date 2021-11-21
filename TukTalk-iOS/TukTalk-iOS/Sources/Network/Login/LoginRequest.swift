//
//  LoginRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    init(_ email: String, _ password: String) {
        self.email = email
        self.password = password
    }
}
