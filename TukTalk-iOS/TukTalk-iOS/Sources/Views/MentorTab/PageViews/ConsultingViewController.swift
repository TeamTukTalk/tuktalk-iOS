//
//  ConsultingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import UIKit

class ConsultingViewController: UIViewController {
    
    //MARK:- Properties
    
    //MARK:- UI Components
    
    private let tempImg = UIImageView().then {
        $0.image = UIImage(named: "updateImg")
    }
    
    private let tempLabel = UILabel().then {
        $0.text = "업데이트 준비중입니다. 잠시만 기다려주세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.sub3
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(tempImg)
        tempImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(tempImg.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
