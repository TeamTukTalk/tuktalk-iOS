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
    
    //MARK:- MyPage
    static let myPageColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
    
    //MARK:- Profile
    
    class Profile: UIColor {
        static let profileBlue = UIColor(red: 229/255, green: 238/255, blue: 255/255, alpha: 1)
        static let nameBlue = UIColor(red: 170/255, green: 199/255, blue: 255/255, alpha: 1)
        static let profileRed = UIColor(red: 255/255, green: 240/255, blue: 240/255, alpha: 1)
        static let nameRed = UIColor(red: 254/255, green: 196/255, blue: 196/255, alpha: 1)
        static let profileYellow = UIColor(red: 255/255, green: 241/255, blue: 211/255, alpha: 1)
        static let nameYellow = UIColor(red: 255/255, green: 206/255, blue: 99/255, alpha: 1)
        static let profileGray = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        static let nameGray = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1)
        static let profileGreen = UIColor(red: 227/255, green: 255/255, blue: 243/255, alpha: 1)
        static let nameGreen = UIColor(red: 124/255, green: 228/255, blue: 183/255, alpha: 1)
        
        static func getProfileColor(color: String) -> UIColor {
            switch color {
            case "profileBlue":
                return profileBlue
            case "profileRed":
                return profileRed
            case "profileYellow":
                return profileYellow
            case "profileGray":
                return profileGray
            case "profileGreen":
                return profileGreen
            default:
                return UIColor()
            }
        }
        
        static func getNameColor(color: String) -> UIColor {
            switch color {
            case "profileBlue":
                return nameBlue
            case "profileRed":
                return nameRed
            case "profileYellow":
                return nameYellow
            case "profileGray":
                return nameGray
            case "profileGreen":
                return nameGreen
            default:
                return UIColor()
            }
        }
    }
}
