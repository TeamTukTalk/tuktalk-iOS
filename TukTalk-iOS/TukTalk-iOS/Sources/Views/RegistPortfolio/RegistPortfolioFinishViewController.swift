//
//  RegistPortfolioFinishViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift
import RxCocoa
import Moya

class RegistPortfolioFinishViewController: UIViewController {
    
    //MARK:- Properties
    
    let provider = MoyaProvider<PortfolioService>()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "포트폴리오 등록 완료!"
        $0.font = UIFont.TTFont(type: .SDBold, size: 18)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "당신의 소중한 경험을 제공해주셔서 감사합니다."
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let conImage = UIImageView().then {
        $0.image = UIImage(named: "conImg")
    }
    
    private let homeBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
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
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            if UIScreen.main.bounds.height == 667 {
                $0.top.equalToSuperview().offset(320)
            } else {
                $0.top.equalToSuperview().offset(420)
            }
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(conImage)
        conImage.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top)
            $0.centerX.equalToSuperview()
        }

        view.addSubview(homeBtn)
        homeBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        homeBtn.rx.tap
            .bind {
                self.uploadPortfolio()
            }
            .disposed(by: disposeBag)
    }
    
    private func uploadPortfolio() {
        let user = UserPortfolio.shared
        let param = PortfolioRequest(description: user.description!, projectCount: user.projectCount!, totalPages: user.totalPages!, startYear: user.startYear!, endYear: user.endYear!, recommendationTargetDescription: user.recommendationTargetDescription!, pdfFileId: user.pdfFileId!, imageFileIds: user.imageFileIds)
        getTest(param: param) { response in
            print(response.id)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func getTest(param: PortfolioRequest, completion: @escaping (PortfolioResponse) -> ()) {
        let provider = MoyaProvider<PortfolioService>()
        provider.rx.request(.portfolioRequest(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                    let responseData = try? response.map(PortfolioResponse.self)
                    guard let data = responseData else { return }
                    print(data)
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
