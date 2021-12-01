//
//  CompanyTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    public static let identifier : String = "CompanyTableViewCell"
    
    private let titleLabel = UILabel().then {
        $0.text = "재직중인 회사 💼"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var companyLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    var confirmImage = UIImageView().then {
        $0.image = UIImage(named: "mentorConfirmImg")
    }
    
    var specialtyLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    var positionLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    var careerLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(company: String, specialty: String, position: String, year: String, month: String) {
        companyLabel.text = "· \(company)"
        specialtyLabel.text = "· \(specialty)"
        positionLabel.text = "· \(position)"
        if month != "0" {
            careerLabel.text = "· \(year)년 \(month)개월"
        } else {
            careerLabel.text = "· \(year)년"
        }
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        contentView.addSubview(confirmImage)
        confirmImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalTo(companyLabel).offset(1)
            $0.leading.equalTo(companyLabel.snp.trailing)
        }
        
        contentView.addSubview(specialtyLabel)
        specialtyLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(companyLabel.snp.bottom).offset(12)
            $0.leading.equalTo(companyLabel.snp.leading)
        }
        
        contentView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(specialtyLabel.snp.bottom).offset(12)
            $0.leading.equalTo(specialtyLabel.snp.leading)
        }
        
        contentView.addSubview(careerLabel)
        careerLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(positionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(positionLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
