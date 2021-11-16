//
//  RegistProfileThirdViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/15.
//

import RxSwift
import RxCocoa

class RegistProfileThirdViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = RegistProfileThirdViewModel()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(0.6))
    private var monthEnable: Bool?
    private let progressIsHiddenValue = BehaviorRelay(value: false)
    var progressPercent: Observable<Float> {
        return progressPercentValue.asObservable()
    }
    var progressIsHidden: Observable<Bool> {
        return progressIsHiddenValue.asObservable()
    }
    
    //MARK:- UI Components
    
    private let backBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.setTitle("프로필 등록/수정", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -15)
    }
    
    private let closeBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "재직중인 회사 정보를 작성해주세요 💼"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let companyLabel = UILabel().then {
        $0.text = "회사명*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let companyTextField = UITextField().then {
        $0.text = "뚝딱회사"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.setLeftPaddingPoints(16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }
    
    private let companySuccessImg = UIImageView().then {
        $0.image = UIImage(named: "successIcon")
    }
    
    private let companyConfirmLabel = UILabel().then {
        $0.text = "회사 인증이 완료되었습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.GrayScale.sub3
    }
    
    private let departmentLabel = UILabel().then {
        $0.text = "부서*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let departMentTextField = UITextField().then {
        $0.text = "UXUI 디자인"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.setLeftPaddingPoints(16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }
    
    private let departmentSuccessImg = UIImageView().then {
        $0.image = UIImage(named: "successIcon")
    }
    
    private let rankLabel = UILabel().then {
        $0.text = "직위*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let rankTextField = UITextField().then {
        $0.placeholder = "사원"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.setLeftPaddingPoints(16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let employmentLabel = UILabel().then {
        $0.text = "근무기간*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let employmentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
    }
    
    private let employmentYearTextField = UITextField().then {
        $0.placeholder = "0"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 29, height: 0))
        $0.textAlignment = .right
        $0.rightView = paddingView
        $0.rightViewMode = .always
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let employmentYearLabel = UILabel().then {
        $0.text = "년"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let employmentMonthTextField = UITextField().then {
        $0.placeholder = "0"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 41, height: 0))
        $0.textAlignment = .right
        $0.rightView = paddingView
        $0.rightViewMode = .always
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let employmentMonthLabel = UILabel().then {
        $0.text = "개월"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let errorLabel = UILabel().then {
        $0.text = "12개월 미만으로 입력해주세요."
        $0.textColor = UIColor.State.error
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.isHidden = true
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 26
        $0.isEnabled = false
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setNaviBar() {
        let leftBarButton = UIBarButtonItem(customView: backBtn)
        let rightBarButton = UIBarButtonItem(customView: closeBtn)
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(114)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(companyTextField)
        companyTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(companyLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(companyConfirmLabel)
        companyConfirmLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(companyTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        companyTextField.addSubview(companySuccessImg)
        companySuccessImg.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(departmentLabel)
        departmentLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(companyConfirmLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(departMentTextField)
        departMentTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(departmentLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        departMentTextField.addSubview(departmentSuccessImg)
        departmentSuccessImg.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(departMentTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(rankTextField)
        rankTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(rankLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(employmentLabel)
        employmentLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(rankTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(employmentStackView)
        employmentStackView.addArrangedSubview(employmentYearTextField)
        employmentStackView.addArrangedSubview(employmentMonthTextField)
        employmentStackView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(employmentLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        employmentYearTextField.addSubview(employmentYearLabel)
        employmentYearLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        employmentMonthTextField.addSubview(employmentMonthLabel)
        employmentMonthLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(employmentStackView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.progressPercentValue.accept(0.4)
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind(onNext: { _ in
                let popUpViewController = PopUpViewController()
                popUpViewController.popUpTitleLabel.text = "프로필 등록을 중단하시겠습니까?"
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.view.endEditing(true)
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            })
            .disposed(by: disposeBag)
        
        rankTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.rankTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)
        
        rankTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.rankTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        employmentYearTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.employmentYearTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)
        
        employmentYearTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.employmentYearTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        employmentMonthTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.employmentMonthTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)
        
        employmentMonthTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.employmentMonthTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        rankTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.rankTitle)
            .disposed(by: disposeBag)
        
        employmentYearTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.inputYear)
            .disposed(by: disposeBag)
        
        employmentYearTextField.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 2 {
                    return previous ?? String(new.prefix(2))
                } else {
                    return new
                }
            }
            .subscribe(employmentYearTextField.rx.text)
            .disposed(by: disposeBag)
        
        employmentMonthTextField.rx.text
            .bind(to: viewModel.input.inputMonth)
            .disposed(by: disposeBag)
        
        viewModel.output.nextBtnEnable
            .drive(onNext: { valid in
                self.nextBtn.backgroundColor = valid ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(valid ? .white : UIColor.GrayScale.sub4, for: .normal)
                self.nextBtn.isEnabled = valid
            })
            .disposed(by: disposeBag)
        
        viewModel.output.monthEnable
            .drive(onNext: { valid in
                self.monthEnable = valid
            })
            .disposed(by: self.disposeBag)
        
        nextBtn.rx.tap
            .bind { _ in
                if self.monthValidation(valid: self.monthEnable ?? false) {
                    let nextVC = RegistProfileFourthViewController()
                    nextVC.progressPercent.subscribe(onNext: { percent in
                        self.progressPercentValue.accept(percent)
                    })
                    .disposed(by: self.disposeBag)
                    nextVC.progressIsHidden.subscribe(onNext: { valid in
                        self.progressIsHiddenValue.accept(valid)
                    })
                    .disposed(by: self.disposeBag)
                    
                    self.navigationController?.pushViewController(nextVC, animated: false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func monthValidation(valid: Bool) -> Bool{
        errorLabel.isHidden = valid
        if !valid { employmentMonthTextField.layer.borderColor = UIColor.State.error.cgColor }
        return valid
    }

}
