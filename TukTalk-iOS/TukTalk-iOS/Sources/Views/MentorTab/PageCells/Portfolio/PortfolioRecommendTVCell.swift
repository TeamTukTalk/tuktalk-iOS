//
//  PortfolioRecommendTVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import UIKit

class PortfolioRecommendTVCell: UITableViewCell {
    
    public static let identifier : String = "PortfolioRecommendTVCell"
    
    private let titleLabel = UILabel().then {
        $0.text = "이런분들께 추천합니다 🙌"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var mainLabel = UILabel().then {
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
    
    func setData(text: String) {
        mainLabel.makeHeightSpacing(thisText: "· \(text)", fontSize: 14)
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }

}
