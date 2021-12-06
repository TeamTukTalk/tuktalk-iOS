//
//  UserPortFoio.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Foundation

class UserPortfolio {
    static let shared = UserPortfolio()
    
    var description: String?
    var projectCount: Int?
    var totalPages: Int?
    var startYear: Int?
    var endYear: Int?
    var recommendationTargetDescription: String?
    var pdfFileId: Int?
    var imageFileIds: [Int] = []
    
    private init() {}
}
