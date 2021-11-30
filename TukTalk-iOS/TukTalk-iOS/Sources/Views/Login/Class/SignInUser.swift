//
//  SignInUser.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Foundation

class SignInUser {
    static let shared = SignInUser()
    
    var role: String?
    
    private init() {}
}
