//
//  AccountSettingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift
import Moya

class AccountSettingViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "계정 설정"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let informationBtn = UIButton()
    private let informationBtnLabel = UILabel().then {
        $0.text = "기본정보"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let logoutBtn = UIButton()
    private let logoutBtnLabel = UILabel().then {
        $0.text = "로그아웃"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let withdrawBtn = UIButton()
    private let withdrawBtnLabel = UILabel().then {
        $0.text = "회원 탈퇴"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBar()
    }
    
    //MARK:- Function
    
    private func setBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
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
        
        view.addSubview(informationBtn)
        informationBtn.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        informationBtn.addSubview(informationBtnLabel)
        informationBtnLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalTo(informationBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        logoutBtn.addSubview(logoutBtnLabel)
        logoutBtnLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalTo(logoutBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        withdrawBtn.addSubview(withdrawBtnLabel)
        withdrawBtnLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        informationBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(MyPageInformationViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        logoutBtn.rx.tap
            .bind {
                let popUpViewController = PopUpViewController()
                popUpViewController.popUpTitleLabel.text = "로그아웃 하시겠습니까?"
                popUpViewController.acceptBtn.setTitle("머무르기", for: .normal)
                popUpViewController.dismissBtn.setTitle("로그아웃", for: .normal)
                popUpViewController.dismissBtn.addTarget(self, action: #selector(self.logOut), for: .touchUpInside)
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            }
            .disposed(by: disposeBag)
        
        withdrawBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(WithdrawViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func logOut() {
        KeyChain.delete(key: "token")
        KeyChain.delete(key: "role")
        KeyChain.delete(key: "nickname")
        KeyChain.delete(key: "firstLetter")
        KeyChain.delete(key: "profileImageColor")
        KeyChain.delete(key: "email")
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first!.replaceRootViewController(loginVC, animated: true, completion: nil)
    }
}
