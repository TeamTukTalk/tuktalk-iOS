//
//  APIConstants.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import UIKit

struct APIConstants {
    
    //MARK:- Base URL
    
    static let baseUrlPath = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "network", ofType: "plist")!)
    static let baseURL = baseUrlPath?.value(forKey: "baseURL") as! String
    
    //MARK:- LogIn URL
    
    /// [POST] 로그인
    static let loginURL = baseURL + "sign-in"
    
    //MARK:- SignUp URL
    
    /// [GET] 이메일 중복 확인
    static let emailOverlapURL = baseURL + "users/validate"
    
    /// [POST] 회원가입
    static let signUpURL = baseURL + "users"
    
}
