//
//  CareerTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/18.
//

import UIKit

class CareerTableViewCell: UITableViewCell {
    
    public static let identifier : String = "CareerTableViewCell"
    
    private let titleLabel = UILabel().then {
        $0.text = "경력/경험 💻"
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
    }

}
