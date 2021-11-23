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
}
