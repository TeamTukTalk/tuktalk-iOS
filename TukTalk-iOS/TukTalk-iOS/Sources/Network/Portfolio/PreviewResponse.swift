//
//  PreviewResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

struct PreviewResponseElement: Codable {
    let id: Int
    let fileURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case fileURL = "fileUrl"
    }
}

typealias PreviewResponse = [PreviewResponseElement]
