//
//  ReviewCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var profileImg = UIImageView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 22
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    var profileBackground = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 22
    }
    var profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
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
    var jobLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    let devideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
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
    
    func setData(model: Review) {
        if model.profileImageURL == "" {
            profileBackground.isHidden = false
            profileLabel.isHidden = false
            profileBackground.backgroundColor = UIColor.Profile.getProfileColor(color: model.profileImageColor)
            profileLabel.textColor = UIColor.Profile.getNameColor(color: model.profileImageColor)
            profileLabel.text = model.firstLetter
            profileImg.isHidden = true
        } else {
            let url = URL(string: model.profileImageURL)
            let data = try? Data(contentsOf: url!)
            profileImg.image = UIImage(data: data!)
            profileImg.isHidden = false
            profileBackground.isHidden = true
            profileLabel.isHidden = true
        }
        nameLabel.text = model.mentor.nickname
        companyLabel.text = model.mentor.companyName
        jobLabel.text = model.mentor.subSpecialty
        starImageView.image = UIImage(named: "star\(model.rating)")
        contentsLabel.text = model.reviewDescription
        menteeNameLabel.text = model.mentee.nickname
        reviewDateLabel.text = model.reviewCreatedDateTime
        
        let dateStr = model.reviewCreatedDateTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let convertDate = dateFormatter.date(from: dateStr) else { return }
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd"
        let convertStr = myDateFormatter.string(from: convertDate)
        reviewDateLabel.text = convertStr
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray4.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.06, x: 4, y: 4, blur: 24, spread: 0)
        contentView.addSubview(profileBackground)
        profileBackground.addSubview(profileLabel)
        contentView.addSubview(profileImg)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(devideDot)
        contentView.addSubview(starImageView)
        contentView.addSubview(contentsLabel)
        contentView.addSubview(menteeNameLabel)
        contentView.addSubview(menteeDevideDot)
        contentView.addSubview(reviewDateLabel)
        
        
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        profileBackground.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        profileLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
            $0.top.equalTo(profileImg.snp.top)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalTo(nameLabel).offset(1)
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        devideDot.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(devideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
        starImageView.snp.makeConstraints {
            $0.height.equalTo(12)
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
