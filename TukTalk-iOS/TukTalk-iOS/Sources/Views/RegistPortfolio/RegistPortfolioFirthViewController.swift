//
//  RegistPortfolioFifthViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/25.
//

import RxSwift
import RxCocoa
import MobileCoreServices
import Moya

class RegistPortfolioFirthViewController: UIViewController {
    
    //MARK:- Properties
    
    //    private lazy var viewModel = RegistPortfolioFifthViewModel()
    private let provider = MoyaProvider<PortfolioService>()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(1.0))
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
        $0.makeHeightSpacing(thisText: "포트폴리오를 업로드해주세요.", fontSize: 17)
    }
    
    private let portfolioLabel = UILabel().then {
        $0.text = "포트폴리오 파일*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let portfolioTextField = UITextField().then {
        $0.placeholder = "pdf로 업로드해주세요."
        $0.setLeftPaddingPoints(16)
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isUserInteractionEnabled = false
    }
    
    private let portfolioUploadBtn = UIButton().then {
        $0.setTitle("추가하기", for: .normal)
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 14)
    }
    
    private let previewLabel = UILabel().then {
        $0.text = "포트폴리오 미리보기 업로드*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let previewSubLabel = UILabel().then {
        $0.text = "(jpg, png로 업로드)"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub3
    }
    
    private let previewUploadBtn = UIButton().then {
        $0.setImage(UIImage(named: "photoBtnImg"), for: .normal)
        $0.setTitle("사진 0/5", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 10)
        $0.titleEdgeInsets = UIEdgeInsets(top: 51, left: -24, bottom: 25, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 27, left: 33, bottom: 41, right: 33)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("등록하기", for: .normal)
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
        
        view.addSubview(portfolioLabel)
        portfolioLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(portfolioUploadBtn)
        portfolioUploadBtn.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(portfolioTextField)
        portfolioTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(portfolioLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(previewLabel)
        previewLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(portfolioTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(previewSubLabel)
        previewSubLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerY.equalTo(previewLabel)
            $0.leading.equalTo(previewLabel.snp.trailing).offset(8)
        }
        
        view.addSubview(previewUploadBtn)
        previewUploadBtn.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.top.equalTo(previewLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
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
                self.progressPercentValue.accept(0.75)
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
        
        portfolioUploadBtn.rx.tap
            .bind { _ in
                let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
                importMenu.delegate = self
                importMenu.modalPresentationStyle = .formSheet
                self.present(importMenu, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    private func uploadPDF(pdfData: Data?, fileName: String) {
        guard let pdfData = pdfData else { return }
        provider.rx.request(.portfolioRequest(pdfData, fileName: fileName))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}

extension RegistPortfolioFirthViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else { return }
        print("import result: \(myURL)")

        do {
            uploadPDF(pdfData: try Data(contentsOf: myURL), fileName: myURL.lastPathComponent)
            portfolioTextField.text = myURL.lastPathComponent
            portfolioTextField.textColor = UIColor.GrayScale.sub2
        } catch {
            print(error)
        }
    }
}
