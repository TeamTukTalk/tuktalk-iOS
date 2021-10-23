//
//  SecondView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import UIKit
import Then
import RxSwift

class EnrollSecondViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var enrollSecondViewModel = EnrollSecondViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let topView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 12
        $0.frame.size.width = 12
    }
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.frame.size.height = 20
        $0.frame.size.width = 20
    }
    
    private let firstLabelIcon = UILabel().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.text = "1"
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let firstLabel = UILabel().then {
        $0.text = "정보입력"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.Primary.primary
    }
    
    private let secondLabelIcon = UILabel().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.text = "2"
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let secondLabel = UILabel().then {
        $0.text = "메일인증"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.Primary.primary
    }
    
    private let thirdLabelIcon = UILabel().then {
        $0.backgroundColor = UIColor.GrayScale.sub4
        $0.text = "3"
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let thirdLabel = UILabel().then {
        $0.text = "등록완료"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 12
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "재직중인 기업 이메일을 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "입력하신 기업 이메일은 암호 처리됩니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일 계정을 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let sendBtn = UIButton().then {
        $0.setTitle("발송", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 24
    }
    
    private let informLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "*외부 이메일 차단 등의 이유로 인증이 불가능한 경우 뚝딱\nabc@company.com 으로 문의해주세요."
        $0.textColor = UIColor.GrayScale.sub3
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 12)
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.GrayScale.gray5
        setUI()
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        emailTextField.text = ""
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.height.equalTo(88)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(firstLabelIcon)
        firstLabelIcon.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalToSuperview().offset(35)
            make.top.equalTo(topView.snp.bottom).offset(20)
        }
        
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstLabelIcon.snp.trailing).offset(4)
            make.centerY.equalTo(firstLabelIcon)
        }
        
        view.addSubview(secondLabelIcon)
        secondLabelIcon.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalTo(firstLabel.snp.trailing).offset(43)
            make.top.equalTo(firstLabelIcon.snp.top)
        }
        
        view.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondLabelIcon.snp.trailing).offset(4)
            make.top.equalTo(firstLabel.snp.top)
        }
        
        view.addSubview(thirdLabelIcon)
        thirdLabelIcon.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalTo(secondLabel.snp.trailing).offset(43)
            make.top.equalTo(secondLabelIcon.snp.top)
        }
        
        view.addSubview(thirdLabel)
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdLabelIcon.snp.trailing).offset(4)
            make.top.equalTo(firstLabel.snp.top)
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(345)
            make.top.equalTo(firstLabelIcon.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(backgroundView.snp.top).offset(32)
            make.centerX.equalTo(backgroundView)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalTo(backgroundView)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.leading.equalTo(backgroundView).offset(20)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(sendBtn)
        sendBtn.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(informLabel)
        informLabel.snp.makeConstraints { make in
            make.top.equalTo(sendBtn.snp.bottom).offset(16)
            make.leading.trailing.equalTo(backgroundView).inset(20)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind(onNext: { _ in
                let popUpViewController = PopUpViewController()
                popUpViewController.popUpTitleLabel.text = "멘토등록을 중단하시겠습니까?"
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .bind(onNext: { _ in
                self.emailTextField.setUnderline(true)
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: enrollSecondViewModel.input.emailText)
            .disposed(by: disposeBag)
        
        enrollSecondViewModel.output.sendIsValid
            .bind(to: sendBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        enrollSecondViewModel.output.sendIsValid
            .filter {$0}
            .bind(onNext: { _ in
                self.sendBtn.setTitleColor(.white, for: .normal)
                self.sendBtn.backgroundColor = UIColor.Primary.primary
            })
            .disposed(by: disposeBag)
        
        enrollSecondViewModel.output.sendIsValid
            .filter {!$0}
            .bind(onNext: { _ in
                self.sendBtn.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                self.sendBtn.backgroundColor = UIColor.GrayScale.gray4
            })
            .disposed(by: disposeBag)
        
        sendBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.pushViewController(EnrollThirdViewController(), animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
}
