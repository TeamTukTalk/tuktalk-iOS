//
//  MenteeMyServiceViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift
import Moya

class MenteeMyServiceViewController: UIViewController {
    
    //MARK:- Properties
    private lazy var viewModel = MyPageViewModel()
    var response: HistoryPortfolioResponse?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "최근 본 포트폴리오"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let menteeServiceNilImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let menteeServiceNilLabel = UILabel().then {
        $0.text = "최근 본 포트폴리오가 없습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let portfolioCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBar()
    }
    
    //MARK:- Function
    
    private func setBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
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
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundView.addSubview(menteeServiceNilImg)
        menteeServiceNilImg.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(102)
        }
        
        backgroundView.addSubview(menteeServiceNilLabel)
        menteeServiceNilLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(menteeServiceNilImg.snp.bottom).offset(10)
        }
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        portfolioCV.setCollectionViewLayout(layout, animated: false)
        portfolioCV.backgroundColor = UIColor.GrayScale.gray5
        portfolioCV.showsVerticalScrollIndicator = false
        portfolioCV.register(MyServiceCVCell.self, forCellWithReuseIdentifier: "MyServiceCVCell")
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setData() {
        
        if response != nil {
            backgroundView.addSubview(portfolioCV)
            portfolioCV.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview()
            }
            setCollectionView()
            bindingCollectionView()
        }
    }
    
    private func bindingCollectionView() {
        menteeServiceNilImg.removeFromSuperview()
        menteeServiceNilLabel.removeFromSuperview()
        
        portfolioCV.rx.setDelegate(self).disposed(by: disposeBag)

        Observable.of(response ?? HistoryPortfolioResponse())
            .bind(to: portfolioCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.portfolioCV.dequeueReusableCell(withReuseIdentifier: "MyServiceCVCell", for: IndexPath.init(row: row, section: 0)) as? MyServiceCVCell {
                    
                    cell.setData(portfolio: item)
                    cell.openBtn.tag = item.mentorID
                    cell.openBtn.addTarget(self, action: #selector(self.openBtnAction), for: .touchUpInside)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func openBtnAction(sender: UIButton) {
        let id = sender.tag
        self.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewModel.getPortfolioData(id: id) { data in
                let nextVC = MyServicePortfolioViewController()
                nextVC.response = data
                self.navigationController?.pushViewController(nextVC, animated: true)
                self.endLoading()
            }
        }
    }
}

extension MenteeMyServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 191)
    }
}
