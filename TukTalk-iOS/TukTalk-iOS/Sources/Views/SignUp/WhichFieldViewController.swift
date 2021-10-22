//
//  WhichFieldInViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/21.
//

import SnapKit
import Then
import RxSwift

class WhichFieldViewController: UIViewController {

    //MARK:- Properties

    private let disposeBag = DisposeBag()

    //MARK:- UI Components
    
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
    
    let titleLabel = UILabel().then {
        $0.text = "어떤 분야에\n관심 있으신가요?👀"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
        $0.layer.cornerRadius = 26
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
    }
    
    private let categoryView = CategoryView()
    
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
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
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(228) /// 나중에 오토레이아웃 적용해야함
            make.width.equalTo(343)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(42)
        }
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind(onNext: { _ in
                let popUpViewController = PopUpViewController()
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
        
        nextBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
}
