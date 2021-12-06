//
//  JobMentorCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import UIKit

class JobMentorCollectionViewCell: UICollectionViewCell {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(mentor: JobSearchResponseElement) {
        if mentor.profileImageURL == "" {
            profileBackground.isHidden = false
            profileLabel.isHidden = false
            profileBackground.backgroundColor = UIColor.Profile.getProfileColor(color: mentor.profileImageColor)
            profileLabel.textColor = UIColor.Profile.getNameColor(color: mentor.profileImageColor)
            profileLabel.text = mentor.firstLetter
            profileImg.isHidden = true
        } else {
            let url = URL(string: mentor.profileImageURL)
            let data = try? Data(contentsOf: url!)
            profileImg.image = UIImage(data: data!)
            profileImg.isHidden = false
            profileBackground.isHidden = true
            profileLabel.isHidden = true
        }
        nameLabel.text = mentor.nickname
        companyLabel.text = mentor.companyName
        jobLabel.text = mentor.department
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray4.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        contentView.addSubview(profileImg)
        contentView.addSubview(profileBackground)
        profileBackground.addSubview(profileLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(devideDot)
        
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
            $0.top.equalTo(profileImg.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalTo(nameLabel).offset(1)
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(20)
        }
        devideDot.snp.makeConstraints {
            $0.height.equalTo(13)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(devideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
    }
}
