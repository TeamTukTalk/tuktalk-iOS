//
//  PortfolioRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

struct PortfolioRequest: Codable {
    let description: String
    let projectCount: Int
    let totalPages: Int
    let startYear: Int
    let endYear: Int
    let recommendationTargetDescription: String
    let pdfFileId: Int
    let imageFileIds: [Int]
}
