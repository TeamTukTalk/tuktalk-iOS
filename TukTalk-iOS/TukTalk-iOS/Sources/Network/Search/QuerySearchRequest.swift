//
//  QuerySearchRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Foundation

struct QuerySearchRequest: Codable {
    let query: String
    let CompanySize: String?
    let subSpecialty: String?
    let startYear: String?
    let page: String?
}
