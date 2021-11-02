//
//  BottomSheetCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/28.
//

import UIKit

class BottomSheetCollectionViewCell: UICollectionViewCell {
    
    var element = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub2
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.Primary.primary.cgColor : UIColor.GrayScale.gray3.cgColor
            self.element.textColor = isSelected ? UIColor.Primary.primary : UIColor.GrayScale.sub2
            self.element.font = isSelected ? UIFont.TTFont(type: .SDBold, size: 14) : UIFont.TTFont(type: .SDMed, size: 14)
            self.element.snp.updateConstraints {
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
    
    func configure(name: String?) {
        element.text = name
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = BottomSheetCollectionViewCell()
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
        contentView.addSubview(element)

        element.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
