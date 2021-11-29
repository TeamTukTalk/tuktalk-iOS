//
//  RegistPortfolioSecondViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import RxSwift
import RxCocoa

class RegistPortfolioSecondViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = RegistPortfolioSecondViewModel()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(0.5))
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
        $0.setTitle("포트폴리오 등록", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -15)
    }
    
    private let closeBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "포트폴리오 정보를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let projectCountLabel = UILabel().then {
        $0.text = "프로젝트 개수*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let projectCountTextField = UITextField().then {
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
    private let projectLabel = UILabel().then {
        $0.text = "개"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let pageCountLabel = UILabel().then {
        $0.text = "총 페이지*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let pageCountTextField = UITextField().then {
        $0.placeholder = "0"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: 0))
        $0.textAlignment = .right
        $0.rightView = paddingView
        $0.rightViewMode = .always
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    private let pageLabel = UILabel().then {
        $0.text = "페이지"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let daysLabel = UILabel().then {
        $0.text = "제작일*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let startYearTextField = UITextField().then {
        $0.placeholder = "2020"
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
    private let startYearLabel = UILabel().then {
        $0.text = "년"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let devideLabel = UILabel().then {
        $0.text = "~"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let endYearTextField = UITextField().then {
        $0.placeholder = "2021"
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
    private let endYearLabel = UILabel().then {
        $0.text = "년"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
        
        view.addSubview(projectCountLabel)
        projectCountLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(projectCountTextField)
        projectCountTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(projectCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        projectCountTextField.addSubview(projectLabel)
        projectLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(pageCountLabel)
        pageCountLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(projectCountTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(pageCountTextField)
        pageCountTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(pageCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        pageCountTextField.addSubview(pageLabel)
        pageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(daysLabel)
        daysLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(pageCountTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(devideLabel)
        devideLabel.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(daysLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(startYearTextField)
        startYearTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(devideLabel)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(devideLabel.snp.leading).offset(-11)
        }
        
        startYearTextField.addSubview(startYearLabel)
        startYearLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(endYearTextField)
        endYearTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(devideLabel)
            $0.leading.equalTo(devideLabel.snp.trailing).offset(11)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        endYearTextField.addSubview(endYearLabel)
        endYearLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
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
        
        nextBtn.rx.tap
            .bind { _ in
                let nextVC = RegistPortfolioThirdViewController()
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
            .disposed(by: disposeBag)
        
        projectCountTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.projectCountTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)

        projectCountTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.projectCountTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        pageCountTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.pageCountTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)

        pageCountTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.pageCountTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        startYearTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.startYearTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)

        startYearTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.startYearTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        endYearTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.endYearTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)

        endYearTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.endYearTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        projectCountTextField.rx.text
            .bind(to: viewModel.input.projectCountInput)
            .disposed(by: disposeBag)
        
        pageCountTextField.rx.text
            .bind(to: viewModel.input.pageCountInput)
            .disposed(by: disposeBag)
        
        startYearTextField.rx.text
            .bind(to: viewModel.input.startYearInput)
            .disposed(by: disposeBag)
        
        endYearTextField.rx.text
            .bind(to: viewModel.input.endYearInput)
            .disposed(by: disposeBag)
        
        viewModel.output.nextIsValid
            .drive(onNext: { status in
                self.nextBtn.isEnabled = status
                self.nextBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
