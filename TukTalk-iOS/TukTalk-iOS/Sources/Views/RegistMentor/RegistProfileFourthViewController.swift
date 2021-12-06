//
//  RegistProfileFourthViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift
import RxCocoa

class RegistProfileFourthViewController: UIViewController {
    
    //MARK:- Properties
    
    private let viewModel = RegistMentorFourthViewModel()
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
        $0.setTitle("프로필 등록/수정", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -15)
    }
    
    private let closeBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "기타 경력/경험이 있다면 작성해주세요 💻"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray3
    }
    
    private let textView = UITextView().then {
        $0.text = "최근 커리어에서 주목할 만한 성과나 업무 경험 (큰 프로젝트 참여, 공모전, 대외활동 등등)"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("건너뛰기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = UIColor.Primary.primary
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
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalTo(devideView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextBtn.snp.top).offset(-12)
        }
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind {
                self.progressPercentValue.accept(0.6)
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind {
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
            }
            .disposed(by: disposeBag)
        
        let initText = "최근 커리어에서 주목할 만한 성과나 업무 경험 (큰 프로젝트 참여, 공모전, 대외활동 등등)"
        
        textView.rx.didBeginEditing
            .bind {
                if self.textView.text == initText { self.textView.text = "" }
                self.textView.textColor = UIColor.GrayScale.sub1
            }
            .disposed(by: disposeBag)
        
        textView.rx.didEndEditing
            .bind {
                if self.textView.text == "" {
                    self.textView.text = initText
                    self.textView.textColor = UIColor.GrayScale.sub4
                }
            }
            .disposed(by: disposeBag)
        
        textView.rx.text
            .bind(onNext: { textViewText in
                if let text = textViewText {
                    if text != initText {
                        self.viewModel.input.inputText.onNext(text)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.textChanged
            .drive(onNext: { status in
                self.nextBtn.setTitle(status ? "다음" : "건너뛰기", for: .normal)
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .bind {
                let nextVC = RegistProfileFifthViewController()
                nextVC.progressPercent.subscribe(onNext: { percent in
                    self.progressPercentValue.accept(percent)
                })
                .disposed(by: self.disposeBag)
                nextVC.progressIsHidden.subscribe(onNext: { valid in
                    self.progressIsHiddenValue.accept(valid)
                })
                .disposed(by: self.disposeBag)
                if self.textView.text != initText {
                    UserMentorRegist.shared.careerDescription = self.textView.text
                } else {
                    UserMentorRegist.shared.careerDescription = ""
                }
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
    }

}
