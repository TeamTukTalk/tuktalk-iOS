//
//  ItdevCategoryCVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import UIKit

class SecondFieldCategoryCVCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub2
        $0.textAlignment = .center
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.Primary.primary.cgColor : UIColor.GrayScale.gray3.cgColor
            self.titleLabel.textColor = isSelected ? UIColor.Primary.primary : UIColor.GrayScale.sub2
            self.titleLabel.font = isSelected ? UIFont.TTFont(type: .SDBold, size: 14) : UIFont.TTFont(type: .SDMed, size: 14)
            self.titleLabel.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(isSelected ? 10 : 14)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func configure(title: String?) {
        titleLabel.text = title
    }
    
    static func fittingSize(availableHeight: CGFloat, title: String?) -> CGSize {
        let cell = SecondFieldCategoryCVCell()
        cell.configure(title: title)
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
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
