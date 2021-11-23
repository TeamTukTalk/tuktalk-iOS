//
//  SignUpClass.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/21.
//

import Foundation

class UserSignUp {
    static let shared = UserSignUp()
    
    var role: String?
    var field: [String] = []
    var nickname: String?
    var email: String?
    var password: String?
    var profileImageColor: String?
    var firstLetter: String?
    
    private init() {}
    
    func getRandomProfileColor() -> String {
        let colorList = ["profileBlue", "profileRed", "profileYellow", "profileGray", "profileGreen"]
        let profileImageColor = colorList.randomElement() ?? ""
        self.profileImageColor = profileImageColor
        return profileImageColor
    }
}
