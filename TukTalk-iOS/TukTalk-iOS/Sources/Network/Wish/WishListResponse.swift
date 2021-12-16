//
//  WishListResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Foundation

// MARK: - WishListResponseElement
struct WishListResponseElement: Codable {
    let id: Int
    let nickname, companyName, department, profileImageURL: String
    let profileImageColor, firstLetter: String
    let hashTags: [HashTag]

    enum CodingKeys: String, CodingKey {
        case id, nickname, companyName, department
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, hashTags
    }
}

typealias WishListResponse = [WishListResponseElement]
