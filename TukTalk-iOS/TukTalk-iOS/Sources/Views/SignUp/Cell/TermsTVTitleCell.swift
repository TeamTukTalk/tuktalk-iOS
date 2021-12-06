//
//  TermsTitleTVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import UIKit

class TermsTVTitleCell: UITableViewCell {
    
    public static let identifier : String = "TermsTVTitleCell"
    
    var titleLabel = UILabel().then {
        $0.textColor = UIColor.GrayScale.normal
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
    }
    
    var arrowImageView = UIImageView()

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
    
    func setData(text: String, open: Bool) {
        titleLabel.text = text
        arrowImageView.image = open ? UIImage(named: "termsDropUpImg") : UIImage(named: "termsDropDownImg")
    }
    
    private func setUI() {
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.bottom.equalToSuperview().inset(17)
            $0.leading.equalToSuperview().offset(16)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
}
