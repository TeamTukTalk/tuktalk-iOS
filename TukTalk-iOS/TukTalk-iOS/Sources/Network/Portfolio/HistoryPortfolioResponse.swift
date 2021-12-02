//
//  HistoryPortfolioResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Foundation

struct HistoryPortfolioResponseElement: Codable {
    let mentorNickname, historyPortfolioResponseDescription, createdDateTime: String
    let pdfURL: String

    enum CodingKeys: String, CodingKey {
        case mentorNickname
        case historyPortfolioResponseDescription = "description"
        case createdDateTime
        case pdfURL = "pdfUrl"
    }
}

typealias HistoryPortfolioResponse = [HistoryPortfolioResponseElement]
