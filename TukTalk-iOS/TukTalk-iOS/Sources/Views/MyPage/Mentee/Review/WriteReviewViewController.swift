//
//  WriteReviewViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift

class WriteReviewViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = MyPageViewModel()
    var response: HistoryPortfolioResponse?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let portfolioCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewUI()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(portfolioCV)
        portfolioCV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setCollectionViewUI() {
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
    
    private func bindingCollectionView() {
        portfolioCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.of(response ?? HistoryPortfolioResponse())
            .bind(to: portfolioCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.portfolioCV.dequeueReusableCell(withReuseIdentifier: "MyServiceCVCell", for: IndexPath.init(row: row, section: 0)) as? MyServiceCVCell {
                    cell.openBtn.setTitle("리뷰 작성하기", for: .normal)
                    cell.openBtn.tag = item.mentorID
                    cell.openBtn.addTarget(self, action: #selector(self.openBtnAction), for: .touchUpInside)
                    cell.setData(portfolio: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        }
    
    @objc private func openBtnAction(sender: UIButton) {
        let nextVC = WriteReviewUploadViewController()
        nextVC.mentorID = sender.tag
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 343, height: 191)
    }
}
