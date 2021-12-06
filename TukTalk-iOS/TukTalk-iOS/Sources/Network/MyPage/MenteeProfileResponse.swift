//
//  MenteeProfileResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Foundation

struct MenteeProfileResponse: Codable {
    let profileImageURL, profileImageColor, firstLetter, nickname: String
    
    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, nickname
    }
}
