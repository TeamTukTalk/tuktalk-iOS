//
//  RegistProfileViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/12.
//

import RxSwift

class RegistProfileFirstViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK:- Properties
    
    private var keyboardFrame: NSValue?
    private let screenHeight = UIScreen.main.bounds.height
    private let disposeBag = DisposeBag()
    private lazy var firstViewModel = RegistProfileFirstViewModel()
    
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
    
    private let progressBar = UIProgressView().then {
        $0.progressTintColor = UIColor.Primary.primary
        $0.trackTintColor = UIColor.GrayScale.gray4
        $0.transform = $0.transform.scaledBy(x: 1, y: 2)
        $0.progressViewStyle = .bar
    }
    
    private let mainScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let mainContentView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: "뚝딱 멘티들에게 보여줄\n기본정보를 입력해주세요 👋", fontSize: 17)
    }
    
    private let profileBackground = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 35
    }
    private let profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "이름(닉네임)*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let nameTextField = UITextField().then {
        $0.text = String(data: KeyChain.load(key: "nickname")!, encoding: .utf8)
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.setLeftPaddingPoints(16)
    }
    
    private let introduceLabel = UILabel().then {
        $0.text = "한줄 소개*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let introduceTextField = UITextField().then {
        $0.placeholder = "한줄 소개를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.setLeftPaddingPoints(16)
    }
    
    private let introduceTFCount = UILabel().then {
        $0.text = "0/50"
        $0.textColor = UIColor.GrayScale.sub3
        $0.font = UIFont.TTFont(type: .SFReg, size: 12)
    }
    
    private let detailIntroduceLabel = UILabel().then {
        $0.text = "상세소개*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let detailIntroduceTextView = UITextView().then {
        $0.text = "멘티에게 어필할 수 있는 소개글을 자세히 작성해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub4
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 8)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
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
        setScrollView()
        setProfileData()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setProgressView()
        mainScrollView.flashScrollIndicators()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        setupAppearance()
    }
    
    private func setProgressView() {
        progressBar.setProgress(0.2, animated: true)
    }
    
    private func setScrollView() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 672)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.isEnabled = true
        tapGesture.cancelsTouchesInView = false
        mainScrollView.addGestureRecognizer(tapGesture)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            if screenHeight <= 736 {
                $0.top.equalToSuperview().offset(94)
            } else {
                $0.top.equalToSuperview().offset(114)
            }
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints {
            $0.width.height.equalTo(mainScrollView.contentSize)
            $0.edges.equalTo(mainScrollView.contentSize)
        }
        
        mainContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(profileBackground)
        profileBackground.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        profileBackground.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.centerY.equalToSuperview()
        }
        
        mainContentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileBackground.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(introduceLabel)
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(introduceTextField)
        introduceTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(introduceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(introduceTFCount)
        introduceTFCount.snp.makeConstraints {
            $0.top.equalTo(introduceTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(detailIntroduceLabel)
        detailIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTextField.snp.bottom).offset(46)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(detailIntroduceTextView)
        detailIntroduceTextView.snp.makeConstraints {
            $0.height.equalTo(140)
            $0.top.equalTo(detailIntroduceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(detailIntroduceTextView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setProfileData() {
        if let nickname = KeyChain.load(key: "nickname") {
            let name = String(data: nickname, encoding: .utf8)
            self.nameLabel.text = "\(name ?? "")님"
        }
        if let firstLetter = KeyChain.load(key: "firstLetter") {
            let first = String(data: firstLetter, encoding: .utf8)
            self.profileLabel.text = first
        }
        if let profileImageColor = KeyChain.load(key: "profileImageColor") {
            let color = String(data: profileImageColor, encoding: .utf8)
            self.profileBackground.backgroundColor = UIColor.Profile.getProfileColor(color: color ?? "")
            self.profileLabel.textColor = UIColor.Profile.getNameColor(color: color ?? "")
        }
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.viewControllers[0].tabBarController?.tabBar.isHidden = false
                self.navigationController?.popViewController(animated: true)
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
                let nextVC = RegistProfileSecondViewController()
                nextVC.progressPercent.subscribe(onNext: { percent in
                    self.progressBar.setProgress(percent, animated: true)
                })
                .disposed(by: self.disposeBag)
                nextVC.progressIsHidden.subscribe(onNext: { valid in
                    self.progressBar.isHidden = valid
                })
                .disposed(by: self.disposeBag)
                UserMentorRegist.shared.nickname = self.nameTextField.text
                UserMentorRegist.shared.simpleIntroDuction = self.introduceTextField.text
                UserMentorRegist.shared.detailedIntroduction = self.detailIntroduceTextView.text
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
        
        introduceTextField.rx.controlEvent(.editingDidBegin)
            .bind { _ in
                self.introduceTextField.layer.borderColor = UIColor.Primary.primary.cgColor
            }
            .disposed(by: disposeBag)
        
        introduceTextField.rx.controlEvent(.editingDidEnd)
            .bind { _ in
                self.introduceTextField.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        introduceTextField.rx.text
            .orEmpty
            .bind(to: firstViewModel.input.introduceText)
            .disposed(by: disposeBag)
        
        detailIntroduceTextView.rx.text
            .orEmpty
            .bind(to: firstViewModel.input.detailText)
            .disposed(by: disposeBag)
        
        introduceTextField.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 50 {
                    return previous ?? String(new.prefix(50))
                } else {
                    return new
                }
            }
            .subscribe(introduceTextField.rx.text)
            .disposed(by: disposeBag)
        
        firstViewModel.output.introduceTextCount
            .subscribe(onNext: { count in
                if count <= 50 {
                    self.introduceTFCount.text = "\(count)/50"
                }
            })
            .disposed(by: disposeBag)
        
        firstViewModel.output.buttonEnable
            .subscribe(onNext: { status in
                self.nextBtn.isEnabled = status
                self.nextBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                let titleColor = status ? .white : UIColor.GrayScale.sub4
                self.nextBtn.setTitleColor(titleColor, for: .normal)
            })
            .disposed(by: disposeBag)
        
        let initText = "멘티에게 어필할 수 있는 소개글을 자세히 작성해주세요."
        
        detailIntroduceTextView.rx.didBeginEditing
            .bind { _ in
                self.detailIntroduceTextView.textColor = UIColor.GrayScale.sub1
                self.detailIntroduceTextView.layer.borderColor = UIColor.Primary.primary.cgColor
                if self.detailIntroduceTextView.text == initText {
                    self.detailIntroduceTextView.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        detailIntroduceTextView.rx.didEndEditing
            .bind { _ in
                if self.detailIntroduceTextView.text == "" {
                    self.detailIntroduceTextView.text = initText
                    self.detailIntroduceTextView.textColor = UIColor.GrayScale.sub4
                }
                self.detailIntroduceTextView.layer.borderColor = UIColor.GrayScale.gray1.cgColor
            }
            .disposed(by: disposeBag)
        
        detailIntroduceTextView.rx.text
            .subscribe(onNext: { text in
                if text != initText && text != "" {
                    self.firstViewModel.input.detailEditingBegin.onNext(true)
                } else {
                    self.firstViewModel.input.detailEditingBegin.onNext(false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func didTapAction(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func keyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardTopPosition = screenHeight - keyboardFrame!.cgRectValue.height
        
        if UIResponder.currentFirst() == introduceTextField {
            let introduceBottomPosition = introduceTextField.frame.origin.y + introduceTextField.frame.height + 94
            if introduceBottomPosition < keyboardTopPosition {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += keyboardTopPosition - introduceBottomPosition - 20
            }
        } else {
            var detailBottomPosition = detailIntroduceTextView.frame.origin.y + detailIntroduceTextView.frame.height
            if screenHeight == 736 {
                detailBottomPosition += 94
            } else if screenHeight > 736 {
                detailBottomPosition += 114
            }
            if detailBottomPosition < keyboardTopPosition {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += keyboardTopPosition - detailBottomPosition - 20
            }
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
