//
//  CategoryView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/22.
//

import UIKit

class CategoryView: UIView {
    
    //MARK:- Properties
    
    private var categoryDataModel = CategoryDataModel()
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
        for i in Range(0...11) {
            self.addSubview(categoryBtn[i])
            categoryBtn[i].snp.makeConstraints({ make in make.height.equalTo(36)})
        }
        categoryBtn[0].snp.makeConstraints { make in
            make.width.equalTo(98)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        categoryBtn[1].snp.makeConstraints { make in
            make.width.equalTo(103)
            make.top.equalToSuperview()
            make.leading.equalTo(categoryBtn[0].snp.trailing).offset(8)
        }
        categoryBtn[2].snp.makeConstraints { make in
            make.width.equalTo(85)
            make.top.equalToSuperview()
            make.leading.equalTo(categoryBtn[1].snp.trailing).offset(8)
        }
        categoryBtn[3].snp.makeConstraints { make in
            make.width.equalTo(97)
            make.top.equalTo(categoryBtn[2].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
        categoryBtn[4].snp.makeConstraints { make in
            make.width.equalTo(162)
            make.top.equalTo(categoryBtn[1].snp.bottom).offset(12)
            make.leading.equalTo(categoryBtn[3].snp.trailing).offset(8)
        }
        categoryBtn[5].snp.makeConstraints { make in
            make.width.equalTo(122)
            make.top.equalTo(categoryBtn[3].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
        categoryBtn[6].snp.makeConstraints { make in
            make.width.equalTo(73)
            make.top.equalTo(categoryBtn[5].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
        categoryBtn[7].snp.makeConstraints { make in
            make.width.equalTo(73)
            make.top.equalTo(categoryBtn[5].snp.bottom).offset(12)
            make.leading.equalTo(categoryBtn[6].snp.trailing).offset(8)
        }
        categoryBtn[8].snp.makeConstraints { make in
            make.width.equalTo(85)
            make.top.equalTo(categoryBtn[5].snp.bottom).offset(12)
            make.leading.equalTo(categoryBtn[7].snp.trailing).offset(8)
        }
        categoryBtn[9].snp.makeConstraints { make in
            make.width.equalTo(72)
            make.top.equalTo(categoryBtn[5].snp.bottom).offset(12)
            make.leading.equalTo(categoryBtn[8].snp.trailing).offset(8)
        }
        categoryBtn[10].snp.makeConstraints { make in
            make.width.equalTo(57)
            make.top.equalTo(categoryBtn[6].snp.bottom).offset(12)
            make.leading.equalToSuperview()
        }
        categoryBtn[11].snp.makeConstraints { make in
            make.width.equalTo(122)
            make.top.equalTo(categoryBtn[6].snp.bottom).offset(12)
            make.leading.equalTo(categoryBtn[10].snp.trailing).offset(8)
        }
    }
    
    private func setData() {
        for i in Range(0...11) {
            categoryBtn.append(UIButton(frame: self.frame).then {
                $0.setTitle(categoryDataModel.categoryDataList[i], for: .normal)
                $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
                $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 14)
                $0.layer.cornerRadius = 17
                $0.titleLabel?.makeHeightSpacing(thisText: $0.titleLabel?.text, fontSize: 14)
            })
            categoryTapped.append(false)
            categoryBtn[i].tag = i
            categoryBtn[i].addTarget(self, action: #selector(btnEvent(_:)), for: .touchUpInside)
        }
    }
    
    @objc func btnEvent(_ sender: UIButton) {
        let number = sender.tag
        if categoryTapped[number] {
            categoryTapped[number] = false
            categoryBtn[number].setTitleColor(UIColor.GrayScale.sub2, for: .normal)
            categoryBtn[number].layer.borderColor = UIColor.GrayScale.gray3.cgColor
        } else {
            categoryTapped[number] = true
            categoryBtn[number].setTitleColor(UIColor.Primary.primary, for: .normal)
            categoryBtn[number].layer.borderColor = UIColor.Primary.primary.cgColor
        }
    }
}
