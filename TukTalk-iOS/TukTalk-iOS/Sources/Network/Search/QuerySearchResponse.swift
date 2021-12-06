//
//  QuerySearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct QuerySearchResponseElement: Codable {
    let id: Int
    let nickname, companyName, department: String
    let hashTags: [HashTag]
}

typealias QuerySearchResponse = [QuerySearchResponseElement]
