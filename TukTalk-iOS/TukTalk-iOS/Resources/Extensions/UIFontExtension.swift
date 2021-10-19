//
//  UIFontExtension.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/18.
//

import UIKit

enum FontType {
    case SFBold, SFMed, SFReg, SFHeader, SDBold, SDMed, SDReg, SDHeader
}
extension UIFont {
    static func TTFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .SFBold:
            fontName = "SFProDisplay-BOLD"
        case .SFMed:
            fontName = "SFProDisplay-MEDIUM"
        case .SFReg:
            fontName = "SFProDisplay-REGULAR"
        case .SFHeader:
            fontName = "SFProDisplay-BOLD"
        case .SDBold:
            fontName = "AppleSDGothicNeo-Bold"
        case .SDMed:
            fontName = "AppleSDGothicNeo-Medium"
        case .SDReg:
            fontName = "AppleSDGothicNeo-Regular"
        case .SDHeader:
            fontName = "AppleSDGothicNeo-BOLD"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
