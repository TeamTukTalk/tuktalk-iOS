//
//  MyPageTableHeaderView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/03.
//

import UIKit

class MyPageTableHeaderView: UIView {
    
    //MARK:- Properties
    
    private let titleImg = UIImageView()
    
    private let title = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    //MARK:- Life Cycle
    
    init(frame: CGRect, user: String, section: Int) {
        super.init(frame: frame)
        self.setData(user: user, section: section)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Function
    
    private func setUI() {
        addSubview(titleImg)
        titleImg.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.centerY.equalTo(titleImg)
            $0.leading.equalTo(titleImg.snp.trailing).offset(8)
        }
        
        addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
            $0.top.equalTo(titleImg.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setData(user: String, section: Int) {
        switch user {
        case "mentor":
            switch section {
            case 0:
                titleImg.image = UIImage(named: "chartImg")
                title.text = "나의 활동"
            default:
                titleImg.image = UIImage(named: "smileImg")
                title.text = "기타 서비스"
            }
        default:
            switch section {
            case 0:
                titleImg.image = UIImage(named: "") ?? UIImage()
                title.text = "나의 활동"
            default:
                titleImg.image = UIImage(named: "smileImg")
                title.text = "기타 서비스"
            }
        }
    }

}
