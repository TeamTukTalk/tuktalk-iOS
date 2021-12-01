//
//  PortfolioPageResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Foundation

struct PortfolioPageResponse: Codable {
    let portfolioPageResponseDescription: String
    let projectCount, totalPages, startYear, endYear: Int
    let recommendationTargetDescription: String
    let price: Int
    let pdfTuktalkFile: String
    let imageFiles: [String]

    enum CodingKeys: String, CodingKey {
        case portfolioPageResponseDescription = "description"
        case projectCount, totalPages, startYear, endYear, recommendationTargetDescription, price, pdfTuktalkFile, imageFiles
    }
}
