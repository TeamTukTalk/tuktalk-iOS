//
//  WriteReviewUploadViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift

class WriteReviewUploadViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = WriteReviewUploadViewModel()
    var mentorID: Int?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "리뷰작성"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "얼마나 만족하셨나요? 🤔"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let initStartImageView = UIImageView().then {
        $0.image = UIImage(named: "star0")
        $0.isUserInteractionEnabled = true
    }
    
    private let start1Btn = UIButton()
    private let start2Btn = UIButton()
    private let start3Btn = UIButton()
    private let start4Btn = UIButton()
    private let start5Btn = UIButton()
    
    private let subTitleLabel = UILabel().then {
        $0.text = "어떤 점이 좋았나요?"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let textView = UITextView().then {
        $0.text = "소중한 후기를 작성해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub4
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    private let uploadBtn = UIButton().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.setTitle("작성완료", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.layer.cornerRadius = 26
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
            $0.height.equalTo(24)
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(initStartImageView)
        initStartImageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(232)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        initStartImageView.addSubview(start1Btn)
        start1Btn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.leading.equalToSuperview()
        }
        initStartImageView.addSubview(start2Btn)
        start2Btn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.equalTo(start1Btn.snp.trailing).offset(8)
        }
        initStartImageView.addSubview(start3Btn)
        start3Btn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.equalTo(start2Btn.snp.trailing).offset(8)
        }
        initStartImageView.addSubview(start4Btn)
        start4Btn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.equalTo(start3Btn.snp.trailing).offset(8)
        }
        initStartImageView.addSubview(start5Btn)
        start5Btn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.equalTo(start4Btn.snp.trailing).offset(8)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(initStartImageView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.height.equalTo(140)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().offset(-102)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(uploadBtn)
        uploadBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-42)
        }
    }
    
    private func binding() {
        textView.rx.text
            .orEmpty
            .bind(to: viewModel.input.textViewInput)
            .disposed(by: disposeBag)
        
        viewModel.output.nextIsValid
            .drive(onNext: { status in
                self.uploadBtn.isEnabled = status
                self.uploadBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.uploadBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
            })
            .disposed(by: disposeBag)
        
        let initText = "소중한 후기를 작성해주세요."
        viewModel.input.initText.onNext(initText)
        
        textView.rx.didBeginEditing
            .bind {
                self.textView.textColor = UIColor.GrayScale.sub1
                if self.textView.text == initText {
                    self.textView.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        textView.rx.didEndEditing
            .bind {
                if self.textView.text == "" {
                    self.textView.textColor = UIColor.GrayScale.sub4
                    self.textView.text = initText
                }
            }
            .disposed(by: disposeBag)
        
        start1Btn.rx.tap
            .bind {
                self.viewModel.rating = 1
                self.initStartImageView.image = UIImage(named: "star1")
            }
            .disposed(by: disposeBag)
        start2Btn.rx.tap
            .bind {
                self.viewModel.rating = 2
                self.initStartImageView.image = UIImage(named: "star2")
            }
            .disposed(by: disposeBag)
        start3Btn.rx.tap
            .bind {
                self.viewModel.rating = 3
                self.initStartImageView.image = UIImage(named: "star3")
            }
            .disposed(by: disposeBag)
        start4Btn.rx.tap
            .bind {
                self.viewModel.rating = 4
                self.initStartImageView.image = UIImage(named: "star4")
            }
            .disposed(by: disposeBag)
        start5Btn.rx.tap
            .bind {
                self.viewModel.rating = 5
                self.initStartImageView.image = UIImage(named: "star5")
            }
            .disposed(by: disposeBag)
    }
}
