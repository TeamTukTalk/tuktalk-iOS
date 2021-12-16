//
//  WrittenReviewViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift

class WrittenReviewViewController: UIViewController {
    
    //MARK:- Properties
    
    //MARK:- UI Components
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let nillImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let nillLabel = UILabel().then {
        $0.text = "작성한 리뷰 내역이 없습니다."
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(nillImg)
        nillImg.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        grayBackgroundView.addSubview(nillLabel)
        nillLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nillImg.snp.bottom).offset(8)
        }
    }
}
