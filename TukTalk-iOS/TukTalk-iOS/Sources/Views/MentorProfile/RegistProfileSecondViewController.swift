//
//  RegistProfileSecondViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/12.
//

import RxSwift
import RxCocoa

class RegistProfileSecondViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(0.4))
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
        $0.text = "전문분야와 상세분야를 선택해주세요 🛠"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let specialityLabel = UILabel().then {
        $0.text = "전문분야*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let specialityBtn = UIButton().then {
        $0.setTitle("전문분야 선택", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 12, left: -8, bottom: 12, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 307, bottom: 10, right: 12)
    }
    
    private let detailFieldTitleLabel = UILabel().then {
        $0.text = "상세분야*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let detailFieldSubLabel = UILabel().then {
        $0.text = "(3개까지 등록 가능)"
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let addFieldBtn = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 14)
    }
    
    private let detailFieldBtn = UIButton().then {
        $0.setTitle("상세분야 선택", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 12, left: -8, bottom: 12, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 307, bottom: 10, right: 12)
        $0.isEnabled = false
    }
    
    private let detailFieldBtn2 = UIButton().then {
        $0.setTitle("상세분야 선택", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 12, left: -8, bottom: 12, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 307, bottom: 10, right: 12)
        $0.isHidden = true
        $0.isEnabled = false
    }
    
    private let detailFieldBtn3 = UIButton().then {
        $0.setTitle("상세분야 선택", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 12, left: -8, bottom: 12, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 307, bottom: 10, right: 12)
        $0.isHidden = true
        $0.isEnabled = false
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
        
        view.addSubview(specialityLabel)
        specialityLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(specialityBtn)
        specialityBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(specialityLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(detailFieldTitleLabel)
        detailFieldTitleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(specialityBtn.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(detailFieldSubLabel)
        detailFieldSubLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(detailFieldTitleLabel.snp.top)
            $0.leading.equalTo(detailFieldTitleLabel.snp.trailing).offset(4)
        }
        
        view.addSubview(addFieldBtn)
        addFieldBtn.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalTo(detailFieldTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(detailFieldBtn)
        detailFieldBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(detailFieldTitleLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(detailFieldBtn2)
        detailFieldBtn2.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(detailFieldBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(detailFieldBtn3)
        detailFieldBtn3.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(detailFieldBtn2.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func nextBtnMakeEnable(bool: Bool) {
        if bool {
            self.nextBtn.isEnabled = bool
            self.nextBtn.backgroundColor = UIColor.Primary.primary
            self.nextBtn.setTitleColor(.white, for: .normal)
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
        
        specialityBtn.rx.tap
            .bind { _ in
                let fieldVC = FieldViewController()
                fieldVC.viewModel.input.selectedBtn.onNext("specialityBtn")
                fieldVC.outputFieldData.bind(onNext: { field in
                    if self.specialityBtn.titleLabel?.text != field && field != "" {
                        self.specialityBtn.setTitle(field, for: .normal)
                        self.detailFieldBtn.setTitle("상세분야 선택", for: .normal)
                        self.detailFieldBtn.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                        self.detailFieldBtn2.setTitle("상세분야 선택", for: .normal)
                        self.detailFieldBtn2.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                        self.detailFieldBtn3.setTitle("상세분야 선택", for: .normal)
                        self.detailFieldBtn3.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                        self.detailFieldBtn2.isHidden = true
                        self.detailFieldBtn3.isHidden = true
                    }
                    self.specialityBtn.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
                    self.detailFieldBtn.isEnabled = true
                    self.detailFieldBtn2.isEnabled = true
                    self.detailFieldBtn3.isEnabled = true
                })
                .disposed(by: self.disposeBag)
                let naviVC = UINavigationController(rootViewController: fieldVC)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        detailFieldBtn.rx.tap
            .bind { _ in
                let fieldVC = FieldViewController()
                fieldVC.viewModel.input.selectedBtn.onNext("detailFieldBtn")
                if let field = self.specialityBtn.titleLabel?.text {
                    fieldVC.viewModel.input.selectedField.onNext(field)
                }
                fieldVC.outputFieldData.bind(onNext: { field in
                    self.detailFieldBtn.setTitle(field, for: .normal)
                    self.detailFieldBtn.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
                })
                .disposed(by: self.disposeBag)
                fieldVC.selectedAll.subscribe(onNext: { bool in
                    self.nextBtnMakeEnable(bool: bool)
                })
                .disposed(by: self.disposeBag)
                let naviVC = UINavigationController(rootViewController: fieldVC)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        detailFieldBtn2.rx.tap
            .bind { _ in
                let fieldVC = FieldViewController()
                fieldVC.viewModel.input.selectedBtn.onNext("detailFieldBtn")
                if let field = self.specialityBtn.titleLabel?.text {
                    fieldVC.viewModel.input.selectedField.onNext(field)
                }
                fieldVC.outputFieldData.bind(onNext: { field in
                    self.detailFieldBtn2.setTitle(field, for: .normal)
                    self.detailFieldBtn2.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
                })
                .disposed(by: self.disposeBag)
                let naviVC = UINavigationController(rootViewController: fieldVC)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        detailFieldBtn3.rx.tap
            .bind { _ in
                let fieldVC = FieldViewController()
                fieldVC.viewModel.input.selectedBtn.onNext("detailFieldBtn")
                if let field = self.specialityBtn.titleLabel?.text {
                    fieldVC.viewModel.input.selectedField.onNext(field)
                }
                fieldVC.outputFieldData.bind(onNext: { field in
                    self.detailFieldBtn3.setTitle(field, for: .normal)
                    self.detailFieldBtn3.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
                })
                .disposed(by: self.disposeBag)
                let naviVC = UINavigationController(rootViewController: fieldVC)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        addFieldBtn.rx.tap
            .bind { _ in
                if !self.detailFieldBtn2.isHidden && !self.detailFieldBtn3.isHidden {
                    return
                }
                if self.detailFieldBtn2.isHidden {
                    self.detailFieldBtn2.isHidden = false
                    return
                }
                if !self.detailFieldBtn2.isHidden {
                    self.detailFieldBtn3.isHidden = false
                }
            }
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .bind { _ in
                let nextVC = RegistProfileThirdViewController()
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
    }

}
