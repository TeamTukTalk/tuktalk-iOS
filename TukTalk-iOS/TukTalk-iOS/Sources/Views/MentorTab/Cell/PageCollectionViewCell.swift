//
//  PageCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.textAlignment = .center
    }
    
    var bottomLineView = UIView().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.textColor = isSelected ? UIColor.Primary.primary : UIColor.GrayScale.sub1
            self.titleLabel.font = isSelected ? UIFont.TTFont(type: .SDBold, size: 14) : UIFont.TTFont(type: .SDMed, size: 14)
            self.bottomLineView.isHidden = isSelected ? false : true
            self.bottomLineView.snp.makeConstraints {
                $0.width.equalTo(12 * (titleLabel.text!.count))
            }
            self.titleLabel.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(isSelected ? 14 : 16)
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
    
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
        }
        
        contentView.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.centerX.equalTo(titleLabel)
        }
    }
}
