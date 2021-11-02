//
//  HashTagCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/31.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textAlignment = .center
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
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = HashTagCollectionViewCell()
        cell.configure(name: name)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private func setUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
