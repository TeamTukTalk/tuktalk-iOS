//
//  MyServiceCVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import UIKit

class MyServiceCVCell: UICollectionViewCell {
    let portfolioIcon = UIImageView().then {
        $0.image = UIImage(named: "portfolioImg")
    }
    let titleLabel = UILabel().then {
        $0.text = "포트폴리오"
        $0.textColor = UIColor.GrayScale.normal
        $0.font = UIFont.TTFont(type: .SFBold, size: 14)
    }
    private var nicknameLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub2
    }
    private let devideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    private let dateLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub2
    }
    let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    let contentsLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub2
    }
    let openBtn = UIButton().then {
        $0.setTitle("열람하기", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 22
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(portfolio: HistoryPortfolioResponseElement) {
        nicknameLabel.text = portfolio.mentorNickname
        contentsLabel.makeHeightSpacing(thisText: portfolio.historyPortfolioResponseDescription, fontSize: 12)
        contentsLabel.numberOfLines = 2
        
        let dateStr = portfolio.createdDateTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let convertDate = dateFormatter.date(from: dateStr) else { return }
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd"
        let convertStr = myDateFormatter.string(from: convertDate)
        dateLabel.text = convertStr
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray3.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        
        contentView.addSubview(portfolioIcon)
        portfolioIcon.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(portfolioIcon.snp.top)
            $0.leading.equalTo(portfolioIcon.snp.trailing).offset(8)
        }
        
        contentView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(portfolioIcon.snp.bottom).offset(4)
            $0.leading.equalTo(portfolioIcon.snp.leading)
        }
        contentView.addSubview(devideDot)
        devideDot.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.top.equalTo(nicknameLabel.snp.top).offset(1)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(6)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(nicknameLabel.snp.top)
            $0.leading.equalTo(devideDot.snp.trailing).offset(6)
        }
        
        contentView.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentView.addSubview(contentsLabel)
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(devideView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentView.addSubview(openBtn)
        openBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-18)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
}
