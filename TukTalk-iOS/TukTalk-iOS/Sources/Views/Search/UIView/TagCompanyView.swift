//
//  TagCompanyView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/28.
//

import UIKit

class TagCompanyView: UIView {

    //MARK:- Properties
    
    private var categoryDataModel = SearchCategoryDataModel()
    private var categoryBtn: [UIButton] = []
    private var categoryTapped: [Bool] = []
    
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
        for i in Range(0...4) {
            self.addSubview(categoryBtn[i])
            categoryBtn[i].snp.makeConstraints({ make in make.height.equalTo(36)})
        }
        categoryBtn[0].snp.makeConstraints { make in
            make.width.equalTo(69)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        categoryBtn[1].snp.makeConstraints { make in
            make.width.equalTo(81)
            make.top.equalToSuperview()
            make.leading.equalTo(categoryBtn[0].snp.trailing).offset(8)
        }
        categoryBtn[2].snp.makeConstraints { make in
            make.width.equalTo(81)
            make.top.equalToSuperview()
            make.leading.equalTo(categoryBtn[1].snp.trailing).offset(8)
        }
        categoryBtn[3].snp.makeConstraints { make in
            make.width.equalTo(81)
            make.top.equalToSuperview()
            make.leading.equalTo(categoryBtn[2].snp.trailing).offset(8)
        }
        categoryBtn[4].snp.makeConstraints { make in
            make.width.equalTo(81)
            make.top.equalTo(categoryBtn[1].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
    }
    
    private func setData() {
        for i in Range(0...4) {
            categoryBtn.append(UIButton(frame: self.frame).then {
                $0.setTitle(categoryDataModel.companyList[i], for: .normal)
                $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
                $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
                $0.layer.cornerRadius = 17
                $0.titleLabel?.textAlignment = .center
            })
            categoryTapped.append(false)
            categoryBtn[i].tag = i
            categoryBtn[i].addTarget(self, action: #selector(btnEvent(_:)), for: .touchUpInside)
        }
    }
    
    @objc func btnEvent(_ sender: UIButton) {
        let number = sender.tag
        if categoryTapped[number] {
            categoryBtn[number].setTitleColor(UIColor.GrayScale.sub2, for: .normal)
            categoryBtn[number].titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
            categoryBtn[number].layer.borderColor = UIColor.GrayScale.gray3.cgColor
        } else {
            categoryBtn[number].setTitleColor(UIColor.Primary.primary, for: .normal)
            categoryBtn[number].titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 14)
            categoryBtn[number].layer.borderColor = UIColor.Primary.primary.cgColor
        }
        categoryTapped[number].toggle()
    }
}
