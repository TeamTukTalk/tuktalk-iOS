//
//  ReviewCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var profileBtn = UIButton()
    var profileImg = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
    }
    var nameLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    let mentorConfirmImg = UIImageView().then {
        $0.image = UIImage(named: "mentorConfirmImg")
    }
    var companyLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    let mentorDevideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    var jobLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    var starImageView = UIImageView()
    var contentsLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    var menteeNameLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.GrayScale.sub3
    }
    let menteeDevideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    var reviewDateLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.GrayScale.sub3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(model: ReviewDataModel) {
        profileImg.image = model.image
        nameLabel.text = model.name
        companyLabel.text = model.company
        jobLabel.text = model.job
        starImageView.image = model.star
        contentsLabel.makeHeightSpacing(thisText: model.contents, fontSize: 13)
        menteeNameLabel.text = model.menteeName
        reviewDateLabel.text = model.date
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray4.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.06, x: 4, y: 4, blur: 24, spread: 0)
        contentView.addSubview(profileImg)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(mentorDevideDot)
        contentView.addSubview(starImageView)
        contentView.addSubview(contentsLabel)
        contentView.addSubview(menteeNameLabel)
        contentView.addSubview(menteeDevideDot)
        contentView.addSubview(reviewDateLabel)
        
        
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        mentorDevideDot.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(mentorDevideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
        starImageView.snp.makeConstraints {
            $0.top.equalTo(profileImg.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        contentsLabel.snp.makeConstraints {
            $0.height.equalTo(72)
            $0.top.equalTo(starImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        menteeNameLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        menteeDevideDot.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.top.equalTo(menteeNameLabel.snp.top)
            $0.leading.equalTo(menteeNameLabel.snp.trailing).offset(4)
        }
        reviewDateLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.leading.equalTo(menteeDevideDot.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().inset(20)
        }
        
    }
}
