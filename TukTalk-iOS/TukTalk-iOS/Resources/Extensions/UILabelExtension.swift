//
//  UILabelExtension.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/19.
//

import UIKit

extension UILabel {
    
    func makeHeightSpacing(thisText: String?, fontSize: CGFloat) {
        numberOfLines = 0
        let attrString = NSMutableAttributedString(string: thisText ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        
        switch fontSize {
        case 32:
            paragraphStyle.lineSpacing = 44/6
        case 28:
            paragraphStyle.lineSpacing = 40/6
        case 24:
            paragraphStyle.lineSpacing = 30/6
        case 18:
            paragraphStyle.lineSpacing = 25/6
        case 17:
            paragraphStyle.lineSpacing = 24/6
        case 16:
            paragraphStyle.lineSpacing = 24/6
        case 15:
            paragraphStyle.lineSpacing = 22/6
        case 14:
            paragraphStyle.lineSpacing = 20/6
        case 13:
            paragraphStyle.lineSpacing = 18/6
        case 12:
            paragraphStyle.lineSpacing = 18/6
        case 11:
            paragraphStyle.lineSpacing = 16/6
        case 10:
            paragraphStyle.lineSpacing = 14/6
        case 20:
            paragraphStyle.lineSpacing = 30/6
        default:
            return
        }
        
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        attributedText = attrString
    }
}
