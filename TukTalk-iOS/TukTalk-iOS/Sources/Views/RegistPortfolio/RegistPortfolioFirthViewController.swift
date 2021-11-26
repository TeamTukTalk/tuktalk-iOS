//
//  RegistPortfolioFirthViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import RxSwift
import RxCocoa

class RegistPortfolioFirthViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = RegistPortfolioFirthViewModel()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(0.8))
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
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: "가격을 책정해주세요!", fontSize: 17)
    }
    
    private let subLabel = UILabel().then {
        $0.text = "100,000원까지 책정하실 수 있습니다."
        $0.textColor = UIColor.GrayScale.sub3
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
    }
    
    private let priceTitleLabael = UILabel().then {
        $0.text = "가격*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let priceTextField = UITextField().then {
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
    private let priceLabel = UILabel().then {
        $0.text = "원"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 26
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
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
        
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
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(priceTitleLabael)
        priceTitleLabael.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(subLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(priceTextField)
        priceTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(priceTitleLabael.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        priceTextField.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.progressPercentValue.accept(0.6)
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind(onNext: { _ in
                let popUpViewController = PopUpViewController()
                popUpViewController.popUpTitleLabel.text = "포트폴리오 등록을 중단하시겠습니까?"
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
                let nextVC = RegistPortfolioFifthViewController()
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
        
        priceTextField.delegate = self
        
        viewModel.output.priceEnable
            .drive(onNext: { status in
                self.nextBtn.isEnabled = status
                self.nextBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}

extension RegistPortfolioFirthViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text?.replacingOccurrences(of: ",", with: "")
        if let text = text {
            viewModel.input.inputText.onNext(text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0
        
        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
            var beforeForemattedString = removeAllSeprator + string
            if formatter.number(from: string) != nil {
                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                    textField.text = formattedString
                    return false
                }
            } else {
                if string == "" {
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        return true
    }
}

