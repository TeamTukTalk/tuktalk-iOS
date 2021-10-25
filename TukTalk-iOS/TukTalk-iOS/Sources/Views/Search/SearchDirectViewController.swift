//
//  SearchDirectViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit
import RxSwift

class SearchDirectViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()

    //MARK:- UI Components
    
    let searchTextField = UITextField().then {
        $0.placeholder = "멘토, 직무 검색"
        $0.setLeftPaddingPoints(32)
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
        $0.becomeFirstResponder()
    }
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 24
        $0.frame.size.width = 24
    }
    
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "searchImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "뚝닥이 추천하는 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
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
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        searchTextField.addSubview(searchBtn)
        searchTextField.addSubview(backBtn)
        searchBtn.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.height.width.equalTo(12)
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().offset(6)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(92)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func binding() {
        searchTextField.rx.text
            .bind { text in
                print(text!)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
    }
}
