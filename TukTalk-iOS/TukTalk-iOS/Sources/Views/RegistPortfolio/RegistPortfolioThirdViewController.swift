//
//  RegistPortfolioThirdViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import RxSwift
import RxCocoa

class RegistPortfolioThirdViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = RegistPortfolioThirdViewModel()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(0.6))
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
        $0.makeHeightSpacing(thisText: "어떤 분들께 추천하나요? 🙌", fontSize: 17)
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray3
    }
    
    private let mainTextView = UITextView().then {
        $0.text = "포트폴리오 제작에 어려움을 느끼시는 분 등등"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub4
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
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
        
        view.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(mainTextView)
        mainTextView.snp.makeConstraints {
            $0.top.equalTo(devideView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-120)
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
                self.progressPercentValue.accept(0.4)
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
        
//        nextBtn.rx.tap
//            .bind { _ in
//                let nextVC = RegistPortfolioFirthViewController()
//                nextVC.progressPercent.subscribe(onNext: { percent in
//                    self.progressBar.setProgress(percent, animated: true)
//                })
//                .disposed(by: self.disposeBag)
//                nextVC.progressIsHidden.subscribe(onNext: { valid in
//                    self.progressBar.isHidden = valid
//                })
//                .disposed(by: self.disposeBag)
//                self.navigationController?.pushViewController(nextVC, animated: false)
//            }
//            .disposed(by: disposeBag)
        
        mainTextView.rx.text
            .orEmpty
            .bind(to: viewModel.input.textViewInput)
            .disposed(by: disposeBag)
        
        viewModel.output.nextIsValid
            .drive(onNext: { status in
                self.nextBtn.isEnabled = status
                self.nextBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
            })
            .disposed(by: disposeBag)
        
        let initText = "포트폴리오 제작에 어려움을 느끼시는 분 등등"
        viewModel.input.initText.onNext(initText)
        
        mainTextView.rx.didBeginEditing
            .bind { _ in
                self.mainTextView.textColor = UIColor.GrayScale.sub1
                if self.mainTextView.text == initText {
                    self.mainTextView.text = ""
                }
            }
            .disposed(by: disposeBag)
    }
}
