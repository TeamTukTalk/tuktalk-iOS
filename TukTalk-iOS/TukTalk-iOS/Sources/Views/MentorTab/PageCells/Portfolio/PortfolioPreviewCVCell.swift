//
//  PortfolioPreviewCVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import UIKit

class PortfolioPreviewCVCell: UICollectionViewCell {
    
    var previewImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(img: UIImage) {
        previewImg.image = img
    }
    
    private func setUI() {
        backgroundColor = UIColor.GrayScale.gray5
        
        contentView.addSubview(previewImg)
        previewImg.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
}
