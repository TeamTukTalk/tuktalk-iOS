//
//  UIColorExtension.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

import UIKit

extension UIColor {
    
    //MARK:- Primary
    
    class Primary: UIColor {
        static let primary = UIColor(red: 67/255, green: 35/255, blue: 219/255, alpha: 1)
        static let primaryDark = UIColor(red: 90/255, green: 55/255, blue: 251/255, alpha: 1)
        static let primaryLight1 = UIColor(red: 162/255, green: 167/255, blue: 254/255, alpha: 1)
        static let primaryLight2 = UIColor(red: 234/255, green: 236/255, blue: 255/255, alpha: 1)
        static let primaryLight3 = UIColor(red: 234/255, green: 236/255, blue: 255/255, alpha: 1)
    }
    
    //MARK:- SubColor
    
    class SubColor: UIColor {
        static let sub1 = UIColor(red: 253/255, green: 96/255, blue: 82/255, alpha: 1)
        static let sub2 = UIColor(red: 255/255, green: 205/255, blue: 97/255, alpha: 1)
    }
    
    //MARK:- State
    
    class State: UIColor {
        static let error = UIColor(red: 255/255, green: 59/255, blue: 59/255, alpha: 1)
        static let warning = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        static let success = UIColor(red: 19/255, green: 194/255, blue: 118/255, alpha: 1)
    }
    
    
    //MARK:- GrayScale
    
    class GrayScale: UIColor {
        static let normal = UIColor(red: 36/255, green: 36/255, blue: 40/255, alpha: 1)
        static let sub1 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        static let sub2 = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)
        static let sub3 = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        static let sub4 = UIColor(red: 174/255, green: 174/255, blue: 174/255, alpha: 1)
        static let sub5 = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
        static let gray1 = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        static let gray2 = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        static let gray3 = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        static let gray4 = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        static let gray5 = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
}
