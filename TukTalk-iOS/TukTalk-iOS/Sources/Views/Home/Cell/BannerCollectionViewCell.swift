//
//  BannerCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/08.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    var bannerImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(img: UIImage) {
        bannerImg.image = img
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.12, x: 4, y: 4, blur: 20, spread: 0)
        
        contentView.addSubview(bannerImg)
        bannerImg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
