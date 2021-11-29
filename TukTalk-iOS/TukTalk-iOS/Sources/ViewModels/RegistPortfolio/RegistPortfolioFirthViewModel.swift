//
//  RegistPortfolioFirthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya
import RxSwift

struct RegistPortfolioFirthViewModel {
    var formData: [MultipartFormData] = []
    var imgData = BehaviorSubject(value: [])
}
