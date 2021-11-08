//
//  CertifyViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift

class EnrollFirstViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var enrollFirstViewModel = EnrollFirstViewModel()
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
        $0.backgroundColor = UIColor.GrayScale.sub4
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
        $0.textColor = UIColor.GrayScale.sub4
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
        $0.text = "현직자 인증하기"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "현재 다니고 있는 회사명과 부서를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let companyLabel = UILabel().then {
        $0.text = "회사명"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let companyTextField = UITextField().then {
        $0.placeholder = "회사명"
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let departmentLabel = UILabel().then {
        $0.text = "부서"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let departmentTextField = UITextField().then {
        $0.placeholder = "웹 디자인"
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 24
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.GrayScale.gray5
        self.navigationController?.navigationBar.isHidden = true
        setUI()
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        [companyTextField, departmentTextField].forEach { $0.text = ""}
    }
    
    //MARK:- Function
    
    private func setUI() {
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
            $0.height.equalTo(380)
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
        
        view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(backgroundView).offset(20)
        }
        
        view.addSubview(companyTextField)
        companyTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(companyLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(departmentLabel)
        departmentLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(companyTextField.snp.bottom).offset(24)
            $0.leading.equalTo(backgroundView).offset(20)
        }
        
        view.addSubview(departmentTextField)
        departmentTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(departmentLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.bottom.equalTo(backgroundView).inset(32)
            $0.leading.trailing.equalTo(backgroundView).inset(20)
        }
    }
    
    private func binding() {
        
        companyTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.companyTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        departmentTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.departmentTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        companyTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.companyTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        departmentTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.departmentTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        companyTextField.rx.text
            .orEmpty
            .bind(to: enrollFirstViewModel.input.companyText)
            .disposed(by: disposeBag)
        
        departmentTextField.rx.text
            .orEmpty
            .bind(to: enrollFirstViewModel.input.departmentText)
            .disposed(by: disposeBag)
        
        enrollFirstViewModel.output.nextIsValid
            .filter {$0}
            .bind { _ in
                self.nextBtn.setTitleColor(.white, for: .normal)
                self.nextBtn.backgroundColor = UIColor.Primary.primary
            }
            .disposed(by: disposeBag)
        
        enrollFirstViewModel.output.nextIsValid
            .filter {!$0}
            .bind { _ in
                self.nextBtn.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                self.nextBtn.backgroundColor = UIColor.GrayScale.gray4
            }
            .disposed(by: disposeBag)
        
        enrollFirstViewModel.output.nextIsValid
            .bind(to: nextBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind { _ in
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
        
        nextBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(EnrollSecondViewController(), animated: false)
            }
            .disposed(by: disposeBag)
    }

}
