//
//  LoginResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/27.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken, nickname, email, profileImageColor: String
    let firstLetter: String
}
