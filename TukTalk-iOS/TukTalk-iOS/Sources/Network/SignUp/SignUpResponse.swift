//
//  SignUpResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Foundation

struct SignUpResponse: Codable {
    let accessToken, nickname, email, profileImageColor: String
    let firstLetter, role: String
}
