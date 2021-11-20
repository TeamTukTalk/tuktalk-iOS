//
//  SignUpClass.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/21.
//

import Foundation

class UserSignUp {
    static let shared = UserSignUp()
    
    var role: String?
    var Field: [String]?
    var nickname: String?
    var email: String?
    var password: String?
    var imageURL: String?
}
