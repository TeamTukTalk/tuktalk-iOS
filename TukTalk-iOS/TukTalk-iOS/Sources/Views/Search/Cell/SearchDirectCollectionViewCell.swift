//
//  SearchDirectCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import UIKit

class SearchDirectCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub2
    }
    var deleteBtn = UIButton().then {
        $0.setImage(UIImage(named: "removeImg"), for: .normal)
        $0.frame.size.height = 16
        $0.frame.size.width = 16
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = SearchDirectCollectionViewCell()
        cell.configure(name: name)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray3.cgColor
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteBtn)

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        deleteBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
