//
//  JobSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct JobSearchResponseElement: Codable {
    let id: Int
    let nickname, companyName, department: String
    let hashTags: [JobSearchHashTag]
}

// MARK: - HashTag
struct JobSearchHashTag: Codable {
    let hashTag: String
}
typealias JobSearchResponse = [JobSearchResponseElement]
