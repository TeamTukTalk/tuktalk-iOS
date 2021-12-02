//
//  WithdrawViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift

class WithdrawViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = WithdrawViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "회원 탈퇴"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let titleLabel = UILabel().then {
        let name = String(data: KeyChain.load(key: "nickname")!, encoding: .utf8)
        $0.text = "\(name!)님\n정말 탈퇴하시겠어요?"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    private let firstDot = UILabel().then {
        $0.text = "᛫"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
    }
    private let firstLabel = UILabel().then {
        $0.text = "지금 탈퇴하시면 등록하신 포트폴리오 기록이 사라져요!"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
    }
    
    private let secondDot = UILabel().then {
        $0.text = "᛫"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
    }
    private let secondLabel = UILabel().then {
        $0.text = "탈퇴 후에는 작성하신 리뷰를 수정 혹은 삭제하실 수 없어요.\n탈퇴 신청 전에 꼭 확인해주세요!"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 14)
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    private let allAgreeBtn = UIButton().then {
        $0.setTitle("회원 탈퇴 유의사항을 확인하였으며 동의합니다.", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
        $0.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
    }
    
    private let withdrawBtn = UIButton().then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 26
        $0.isEnabled = false
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK:- Function
    
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
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(firstDot)
        firstDot.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(firstDot)
            $0.leading.equalTo(firstDot.snp.trailing).offset(8)
        }
        
        view.addSubview(secondDot)
        secondDot.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(firstLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        view.addSubview(secondLabel)
        secondLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(secondDot)
            $0.leading.equalTo(secondDot.snp.trailing).offset(8)
        }
        
        view.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(secondLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(allAgreeBtn)
        allAgreeBtn.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(devideView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints {
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
        
        allAgreeBtn.rx.tap
            .scan(false) { state, _ in
                !state
            }
            .bind(onNext: { state in
                self.viewModel.agreeBtnState.onNext(state)
                state ? self.allAgreeBtn.setImage(UIImage(named: "allCheckOnImg"), for: .normal) : self.allAgreeBtn.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
            })
            .disposed(by: disposeBag)
        
        withdrawBtn.rx.tap
            .bind {
                self.viewModel.withdrawRequest()
                UIApplication.shared.windows.filter { $0.isKeyWindow }.first!.replaceRootViewController(LoginViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.withdrawBtnCheck
            .drive(onNext: { status in
                self.withdrawBtn.isEnabled = status
                self.withdrawBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
                self.withdrawBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
            })
            .disposed(by: disposeBag)
    }
}
