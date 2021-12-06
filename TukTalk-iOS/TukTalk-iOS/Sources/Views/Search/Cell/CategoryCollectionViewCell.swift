//
//  SearchingCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.sub2
        $0.clipsToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.Primary.primary : UIColor.GrayScale.gray5
            self.titleLabel.textColor = isSelected ? .white : UIColor.GrayScale.sub2
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
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = CategoryCollectionViewCell()
        cell.configure(name: name)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func setUI() {
        backgroundColor = UIColor.GrayScale.gray5
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
