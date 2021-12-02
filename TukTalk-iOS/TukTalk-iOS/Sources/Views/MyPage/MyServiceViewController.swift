//
//  MentorServiceViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift

class MyServiceViewController: UIViewController {
    
    //MARK:- Properties
    
    private let user = String(data: KeyChain.load(key: "role")!, encoding: .utf8)
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let uploadBtn = UIButton().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.setTitle("등록하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.layer.cornerRadius = 26
    }
    
    
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(backBtnLabel)
        backBtnLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backBtn)
            $0.leading.equalTo(backBtn.snp.trailing).offset(4)
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        if user == "MENTOR" {
            backBtnLabel.text = "서비스 관리"
            
            view.addSubview(uploadBtn)
            uploadBtn.snp.makeConstraints {
                $0.height.equalTo(52)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().offset(-42)
            }
        } else {
            backBtnLabel.text = "최근 본 포트폴리오"
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        uploadBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(RegistPortfolioFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
