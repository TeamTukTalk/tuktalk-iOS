//
//  JobMentorCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import UIKit

class JobMentorCollectionViewCell: UICollectionViewCell {
    
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
    
    func setData(mentor: MentorListDataModel) {
        profileImg.image = mentor.image
        nameLabel.text = mentor.name
        companyLabel.text = mentor.company
        jobLabel.text = mentor.job
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray4.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        contentView.addSubview(profileImg)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(devideDot)
        
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(profileImg.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalTo(nameLabel)
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
