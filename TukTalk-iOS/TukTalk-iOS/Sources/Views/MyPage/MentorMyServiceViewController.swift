//
//  MentorMyServiceViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift

class MentorMyServiceViewController: UIViewController {
    
    //MARK:- Properties
    var response: PortfolioPageResponse?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "서비스 관리"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let mentorServiceNilImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let mentorServiceNilLabel = UILabel().then {
        $0.text = "등록한 서비스가 없습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let registBtn = UIButton().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.setTitle("등록하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 26
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
        setData()
    }
    
    //MARK:- Function
    
    private func setBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setData() {
        if response != nil {
            mentorServiceNilImg.removeFromSuperview()
            mentorServiceNilLabel.removeFromSuperview()
            
            let mentorServiceView = UIView().then {
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 8
                $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
                $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
            }
            
            backgroundView.addSubview(mentorServiceView)
            
            mentorServiceView.snp.makeConstraints {
                $0.height.equalTo(193)
                $0.top.equalToSuperview().offset(20)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
            
            let portfolioIcon = UIImageView().then {
                $0.image = UIImage(named: "portfolioImg")
            }
            let titleLabel = UILabel().then {
                $0.text = "포트폴리오"
                $0.textColor = UIColor.GrayScale.normal
                $0.font = UIFont.TTFont(type: .SDBold, size: 14)
            }
            let devideView = UIView().then {
                $0.backgroundColor = UIColor.GrayScale.gray4
            }
            let contentsLabel = UILabel().then {
                $0.text = ""
                $0.font = UIFont.TTFont(type: .SDReg, size: 12)
                $0.textColor = UIColor.GrayScale.sub2
                $0.makeHeightSpacing(thisText: response?.portfolioPageResponseDescription, fontSize: 12)
                $0.numberOfLines = 2
            }
            let viewDetails = UIButton().then {
                $0.setTitle("상세보기", for: .normal)
                $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
                $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
                $0.backgroundColor = .white
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 22
                $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            
            mentorServiceView.addSubview(portfolioIcon)
            portfolioIcon.snp.makeConstraints {
                $0.width.height.equalTo(20)
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().offset(20)
            }
            mentorServiceView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.top.equalTo(portfolioIcon.snp.top)
                $0.leading.equalTo(portfolioIcon.snp.trailing).offset(8)
            }
            mentorServiceView.addSubview(devideView)
            devideView.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.top.equalTo(titleLabel.snp.bottom).offset(30)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            mentorServiceView.addSubview(contentsLabel)
            contentsLabel.snp.makeConstraints {
                $0.top.equalTo(devideView.snp.bottom).offset(8)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            mentorServiceView.addSubview(viewDetails)
            viewDetails.snp.makeConstraints {
                $0.height.equalTo(44)
                $0.top.equalTo(contentsLabel.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            
            viewDetails.rx.tap
                .bind {
                    let nextVC = MyServicePortfolioViewController()
                    nextVC.response = self.response
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                .disposed(by: disposeBag)
        }
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
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(48)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        backgroundView.addSubview(mentorServiceNilImg)
        mentorServiceNilImg.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(102)
        }
        
        backgroundView.addSubview(mentorServiceNilLabel)
        mentorServiceNilLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mentorServiceNilImg.snp.bottom).offset(10)
        }
        
        backgroundView.addSubview(registBtn)
        registBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        registBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(RegistPortfolioFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
