//
//  SearchViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit
import RxSwift

class SearchMainViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()

    //MARK:- UI Components
    
    private let searchTextBtn = UIButton().then {
        $0.setTitle("멘토, 직무 검색", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
    }
    
    private let searchTextUnderline = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray1
    }
    
    private let searchImg = UIImageView().then {
        $0.image = UIImage(named: "searchImg")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "관심 분야의 멘토와 포트폴리오를 찾아보세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let designBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
    }
    
    private let designLabel = UILabel().then {
        $0.text = "디자인"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let designImg = UIImageView().then {
        $0.image = UIImage(named: "designBtnImg")
    }
    
    private let itDevBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
    }
    
    private let itDevLabel = UILabel().then {
        $0.text = "IT/개발"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let itDevImg = UIImageView().then {
        $0.image = UIImage(named: "itDevBtnImg")
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextBtn)
        searchTextBtn.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        searchTextBtn.addSubview(searchImg)
        searchImg.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        view.addSubview(searchTextUnderline)
        searchTextUnderline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(searchTextBtn.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextUnderline.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(designBtn)
        designBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(144)
            $0.width.equalTo(164)
        }
        
        designBtn.addSubview(designLabel)
        designLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        designBtn.addSubview(designImg)
        designImg.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(itDevBtn)
        itDevBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(144)
            $0.width.equalTo(164)
        }
        
        itDevBtn.addSubview(itDevLabel)
        itDevLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        itDevBtn.addSubview(itDevImg)
        itDevImg.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func binding() {
        searchTextBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(SearchDirectViewController(), animated: false)
            }
            .disposed(by: disposeBag)
        
        designBtn.rx.tap
            .bind { _ in
                let nextVC = SearchingViewController()
                nextVC.searchTextBtn.setTitle("디자인", for: .normal)
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
        
        itDevBtn.rx.tap
            .bind { _ in
                let nextVC = SearchingViewController()
                nextVC.searchTextBtn.setTitle("IT/개발", for: .normal)
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
    }
}
