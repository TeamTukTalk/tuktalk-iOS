//
//  SecondView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift
import Moya

class CertifyMentorSecondViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = CertifyMentorSecondViewModel()
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
    
    private let backLabel = UILabel().then {
        $0.text = "멘토등록"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
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
    
    private let errorLabel = UILabel().then {
        $0.text = "이메일 인증을 실패했습니다."
        $0.textColor = UIColor.State.error
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.isHidden = true
    }
    
    private let errorIcon = UIImageView().then {
        $0.image = UIImage(named: "errorIcon")
        $0.isHidden = true
    }
    
    private let sendBtn = UIButton().then {
        $0.setTitle("발송", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 24
        $0.isEnabled = false
    }
    
    private let resendBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("재발송", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 24
    }
    
    private let confirmBtn = UIButton().then {
        $0.setTitle("인증완료", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
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
        setUI()
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        emailTextField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = UIColor.GrayScale.gray5
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.height.equalTo(88)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.bottom.equalTo(topView.snp.bottom).inset(10)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(backLabel)
        backLabel.snp.makeConstraints {
            $0.bottom.equalTo(topView.snp.bottom).inset(10)
            $0.leading.equalTo(backBtn.snp.trailing).offset(4)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.bottom.equalTo(topView.snp.bottom).inset(12)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(firstLabelIcon)
        firstLabelIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalTo(topView.snp.bottom).offset(20)
        }
        
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.leading.equalTo(firstLabelIcon.snp.trailing).offset(4)
            $0.centerY.equalTo(firstLabelIcon)
        }
        
        view.addSubview(secondLabelIcon)
        secondLabelIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalTo(firstLabel.snp.trailing).offset(43)
            $0.top.equalTo(firstLabelIcon.snp.top)
        }
        
        view.addSubview(secondLabel)
        secondLabel.snp.makeConstraints {
            $0.leading.equalTo(secondLabelIcon.snp.trailing).offset(4)
            $0.top.equalTo(firstLabel.snp.top)
        }
        
        view.addSubview(thirdLabelIcon)
        thirdLabelIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalTo(secondLabel.snp.trailing).offset(43)
            $0.top.equalTo(secondLabelIcon.snp.top)
        }
        
        view.addSubview(thirdLabel)
        thirdLabel.snp.makeConstraints {
            $0.leading.equalTo(thirdLabelIcon.snp.trailing).offset(4)
            $0.top.equalTo(firstLabel.snp.top)
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(345)
            $0.top.equalTo(firstLabelIcon.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backgroundView.snp.top).offset(32)
            $0.centerX.equalTo(backgroundView)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(backgroundView)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(backgroundView).offset(20)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(errorIcon)
        errorIcon.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(13)
            $0.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.equalTo(backgroundView).offset(20)
        }
        
        view.addSubview(sendBtn)
        sendBtn.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(emailTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(informLabel)
        informLabel.snp.makeConstraints {
            $0.top.equalTo(sendBtn.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind {
                self.view.endEditing(true)
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
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .bind {
                self.emailTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.emailText)
            .disposed(by: disposeBag)
        
        viewModel.output.sendIsValid
            .drive { status in
                self.sendBtn.setTitleColor( status ? .white : UIColor.GrayScale.sub4, for: .normal)
                self.sendBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.sendBtn.isEnabled = status
            }
            .disposed(by: disposeBag)
        
        sendBtn.rx.tap
            .bind {
                if self.viewModel.enableCompanyCheck(email: self.emailTextField.text!) {
                    self.errorIcon.isHidden = true
                    self.errorLabel.isHidden = true
                    self.updateBtnUI()
                    self.viewModel.sendEmailRequest(email: self.emailTextField.text!)
                } else {
                    self.errorLabel.text = "뚝딱에 등록되지 않은 기업입니다."
                    self.errorIcon.isHidden = false
                    self.errorLabel.isHidden = false
                }
            }
            .disposed(by: disposeBag)
        
        resendBtn.rx.tap
            .bind {
                self.viewModel.sendEmailRequest(email: self.emailTextField.text!)
            }
            .disposed(by: disposeBag)
        
        confirmBtn.rx.tap
            .bind {
                self.viewModel.verifyEmailRequest() { response in
                    if response.certifiedMentor {
                        self.navigationController?.pushViewController(CertifyMentorFinishViewController(), animated: true)
                    } else {
                        self.resendBtn.snp.updateConstraints {
                            $0.top.equalTo(self.emailTextField.snp.bottom).offset(46)
                        }
                        self.backgroundView.snp.updateConstraints {
                            $0.height.equalTo(407)
                        }
                        self.errorLabel.text = "이메일 인증을 실패했습니다."
                        self.errorLabel.isHidden = false
                        self.errorIcon.isHidden = false
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func updateBtnUI() {
        
        sendBtn.removeFromSuperview()
        
        view.addSubview(resendBtn)
        resendBtn.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(emailTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(resendBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        informLabel.snp.removeConstraints()
        informLabel.snp.makeConstraints {
            $0.top.equalTo(confirmBtn.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        backgroundView.snp.updateConstraints {
            $0.height.equalTo(393)
        }
    }
}
