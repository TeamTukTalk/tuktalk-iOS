//
//  PortfolioInformTVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import UIKit

class PortfolioInformTVCell: UITableViewCell {
    
    public static let identifier : String = "PortfolioInformTVCell"
    
    private let titleLabel = UILabel().then {
        $0.text = "포트폴리오 정보"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var projectCountLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    var totalPagesLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    var dateLabel = UILabel().then {
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
    
    func setData(projectCount: String, totalPages: String, startYear: String, endYear: String) {
        projectCountLabel.text = "· 프로젝트  \(projectCount)개"
        totalPagesLabel.text = "· 페이지  \(totalPages)p"
        dateLabel.text = "· 제작일  \(startYear) - \(endYear)"
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(projectCountLabel)
        projectCountLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        contentView.addSubview(totalPagesLabel)
        totalPagesLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(projectCountLabel.snp.bottom).offset(12)
            $0.leading.equalTo(projectCountLabel.snp.leading)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(totalPagesLabel.snp.bottom).offset(12)
            $0.leading.equalTo(totalPagesLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
