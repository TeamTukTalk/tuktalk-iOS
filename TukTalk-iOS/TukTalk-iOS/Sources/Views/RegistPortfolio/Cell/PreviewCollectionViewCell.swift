//
//  PreviewCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import UIKit

class PreviewCollectionViewCell: UICollectionViewCell {
    
    var previewImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var deleteBtn = UIButton().then {
        $0.setImage(UIImage(named: "deleteBtnImg"), for: .normal)
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
        previewImageView.image = img
    }
    
    private func setUI() {
        backgroundColor = UIColor.GrayScale.gray4
        layer.cornerRadius = 8
        contentView.addSubview(previewImageView)
        contentView.addSubview(deleteBtn)
        
        previewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        
    }
}
