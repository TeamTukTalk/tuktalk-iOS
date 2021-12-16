//
//  PortfolioPageResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Foundation

struct PortfolioPageResponse: Codable {
    let portfolioID: Int
    let createdDateTime, reviewSearchResponseDescription: String
    let projectCount, totalPages, startYear, endYear: Int
    let recommendationTargetDescription: String
    let pdfTuktalkFile: String
    let imageFiles: [String]

    enum CodingKeys: String, CodingKey {
        case portfolioID = "portfolioId"
        case createdDateTime
        case reviewSearchResponseDescription = "description"
        case projectCount, totalPages, startYear, endYear, recommendationTargetDescription, pdfTuktalkFile, imageFiles
    }
}
