//
//  RecommendView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import UIKit

class RecommendView: UIView {
    
    //MARK:- Properties
    
    private var recommendDataModel = SearchRecommendDataModel()
    private var recommendLabel: [UILabel] = []
    
    //MARK:- Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setData()
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setData()
        self.setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        for i in Range(0...6) {
            self.addSubview(recommendLabel[i])
            recommendLabel[i].snp.makeConstraints({ make in make.height.equalTo(36)})
            recommendLabel[i].textAlignment = .center
            recommendLabel[i].layer.cornerRadius = 18
        }
        recommendLabel[0].snp.makeConstraints { make in
            make.width.equalTo(105)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        recommendLabel[1].snp.makeConstraints { make in
            make.width.equalTo(69)
            make.top.equalToSuperview()
            make.leading.equalTo(recommendLabel[0].snp.trailing).offset(8)
        }
        recommendLabel[2].snp.makeConstraints { make in
            make.width.equalTo(133)
            make.top.equalToSuperview()
            make.leading.equalTo(recommendLabel[1].snp.trailing).offset(8)
        }
        recommendLabel[3].snp.makeConstraints { make in
            make.width.equalTo(69)
            make.top.equalTo(recommendLabel[0].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
        recommendLabel[4].snp.makeConstraints { make in
            make.width.equalTo(69)
            make.top.equalTo(recommendLabel[1].snp.bottom).offset(12)
            make.leading.equalTo(recommendLabel[3].snp.trailing).offset(8)
        }
        recommendLabel[5].snp.makeConstraints { make in
            make.width.equalTo(57)
            make.top.equalTo(recommendLabel[1].snp.bottom).offset(12)
            make.leading.equalTo(recommendLabel[4].snp.trailing).offset(8)
        }
        recommendLabel[6].snp.makeConstraints { make in
            make.width.equalTo(57)
            make.top.equalTo(recommendLabel[2].snp.bottom).offset(12)
            make.leading.equalTo(recommendLabel[5].snp.trailing).offset(8)
        }
    }
    
    private func setData() {
        for i in Range(0...6) {
            recommendLabel.append(UILabel(frame: self.frame).then {
                $0.clipsToBounds = true
                $0.text = recommendDataModel.recommendList[i]
                $0.textColor = UIColor.Primary.primary
                $0.font = UIFont.TTFont(type: .SDBold, size: 14)
                $0.backgroundColor = UIColor.Primary.primaryLight3
            })
        }
    }
}
