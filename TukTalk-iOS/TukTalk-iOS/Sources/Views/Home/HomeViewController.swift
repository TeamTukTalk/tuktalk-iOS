//
//  HomeViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import RxSwift

class HomeViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var bannerViewModel = BannerCollectionViewModel()
    private lazy var mentorListViewModel = MentorListCollectionViewModel()
    private lazy var categoryViewModel = SearchesCollectionViewModel()
    private lazy var reviewListViewModel = ReviewCollectionViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let mainScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let mainContentView = UIView()
    
    private let logoImg = UIImageView().then {
        $0.image = UIImage(named: "logoImg")
    }
    
    private let bellBtn = UIButton().then {
        $0.setImage(UIImage(named: "bellImg"), for: .normal)
    }
    
    private let bannerCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let topLabel = UILabel().then {
        $0.text = "가장 인기있는 TOP5 뚝딱멘토 🎉"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let topMentorCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let jobLabel = UILabel().then {
        $0.text = "직무별 뚝딱멘토"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let jobViewAllBtn = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
    }
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let jobMentorCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let reviewLabel = UILabel().then {
        $0.text = "뚝딱멘티들의 실시간 후기 📋"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let reviewViewAllBtn = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
    }
    
    private let reviewCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let bottomTitleLabel = UILabel().then {
        $0.text = "뚝딱멘토 활동을 시작해보세요!"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let bottomSubLabel = UILabel().then {
        $0.text = "여러분이 열심히 쌓아온 경험의 가치를 환산해보세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let bottomFirstBannerBtn = UIButton().then {
        $0.setImage(UIImage(named: "bottomBanner1"), for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.applyShadow(color: .black, alpha: 0.12, x: 4, y: 4, blur: 20, spread: 0)
    }
    private let bottomSecondBannerBtn = UIButton().then {
        $0.setImage(UIImage(named: "bottomBanner2"), for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.applyShadow(color: .black, alpha: 0.12, x: 4, y: 4, blur: 20, spread: 0)
    }

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setScrollView() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1600)
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints {
            $0.width.height.equalTo(mainScrollView.contentSize)
            $0.edges.equalTo(mainScrollView.contentSize)
        }
        
        mainContentView.addSubview(logoImg)
        logoImg.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.width.equalTo(76)
            $0.top.equalToSuperview().offset(59)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(bellBtn)
        bellBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(bannerCV)
        bannerCV.snp.makeConstraints {
            $0.height.equalTo(254)
            $0.top.equalTo(bellBtn.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(topLabel)
        topLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(bannerCV.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(topMentorCV)
        topMentorCV.snp.makeConstraints {
            $0.height.equalTo(153)
            $0.top.equalTo(topLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(topMentorCV.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(jobViewAllBtn)
        jobViewAllBtn.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerY.equalTo(jobLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(jobLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(jobMentorCV)
        jobMentorCV.snp.makeConstraints {
            $0.height.equalTo(158)
            $0.top.equalTo(categoryCV.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.height.equalTo(362)
            $0.top.equalTo(jobMentorCV.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(reviewLabel)
        reviewLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(40)
        }
        
        grayBackgroundView.addSubview(reviewViewAllBtn)
        reviewViewAllBtn.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerY.equalTo(reviewLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        grayBackgroundView.addSubview(reviewCV)
        reviewCV.snp.makeConstraints {
            $0.height.equalTo(262)
            $0.top.equalTo(reviewLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(bottomTitleLabel)
        bottomTitleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(grayBackgroundView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(91)
        }
        
        mainContentView.addSubview(bottomSubLabel)
        bottomSubLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(bottomTitleLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(64)
        }
        
        mainContentView.addSubview(bottomFirstBannerBtn)
        bottomFirstBannerBtn.snp.makeConstraints {
            $0.top.equalTo(bottomSubLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(bottomSecondBannerBtn)
        bottomSecondBannerBtn.snp.makeConstraints {
            $0.top.equalTo(bottomSubLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        jobViewAllBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.pushViewController(JobMentorListViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setCollectionViewUI() {
        let bannerCVLayout = UICollectionViewFlowLayout()
        bannerCVLayout.minimumLineSpacing = 8
        bannerCVLayout.scrollDirection = .horizontal
        bannerCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        bannerCV.setCollectionViewLayout(bannerCVLayout, animated: false)
        bannerCV.backgroundColor = .white
        bannerCV.showsHorizontalScrollIndicator = false
        bannerCV.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        let topMentorCVLayout = UICollectionViewFlowLayout()
        topMentorCVLayout.minimumLineSpacing = 8
        topMentorCVLayout.scrollDirection = .horizontal
        topMentorCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 16)
        topMentorCV.setCollectionViewLayout(topMentorCVLayout, animated: false)
        topMentorCV.backgroundColor = .white
        topMentorCV.showsHorizontalScrollIndicator = false
        topMentorCV.register(TopMentorCollectionViewCell.self, forCellWithReuseIdentifier: "TopMentorCollectionViewCell")
        
        let categoryCVLayout = UICollectionViewFlowLayout()
        categoryCVLayout.minimumInteritemSpacing = 8
        categoryCVLayout.scrollDirection = .horizontal
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        categoryCV.setCollectionViewLayout(categoryCVLayout, animated: false)
        categoryCV.backgroundColor = .white
        categoryCV.showsHorizontalScrollIndicator = false
        categoryCV.register(SearchingCollectionViewCell.self, forCellWithReuseIdentifier: "SearchingCollectionViewCell")
        
        let jobMentorCVLayout = UICollectionViewFlowLayout()
        jobMentorCVLayout.minimumLineSpacing = 8
        jobMentorCVLayout.scrollDirection = .horizontal
        jobMentorCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 16)
        jobMentorCV.setCollectionViewLayout(jobMentorCVLayout, animated: false)
        jobMentorCV.backgroundColor = .white
        jobMentorCV.showsHorizontalScrollIndicator = false
        jobMentorCV.register(JobMentorCollectionViewCell.self, forCellWithReuseIdentifier: "JobMentorCollectionViewCell")
        
        let reviewCVLayout = UICollectionViewFlowLayout()
        reviewCVLayout.minimumLineSpacing = 12
        reviewCVLayout.scrollDirection = .horizontal
        reviewCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 28, right: 40)
        reviewCV.setCollectionViewLayout(reviewCVLayout, animated: false)
        reviewCV.backgroundColor = UIColor.GrayScale.gray5
        reviewCV.showsHorizontalScrollIndicator = false
        reviewCV.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
    }
    
    private func bindingCollectionView() {
        bannerCV.rx.setDelegate(self).disposed(by: disposeBag)
        topMentorCV.rx.setDelegate(self).disposed(by: disposeBag)
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        jobMentorCV.rx.setDelegate(self).disposed(by: disposeBag)
        reviewCV.rx.setDelegate(self).disposed(by: disposeBag)

        bannerViewModel.output.bannerListData
            .bind(to: bannerCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.bannerCV.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BannerCollectionViewCell {
                    
                    cell.setData(img: item.image)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        mentorListViewModel.output.topMentorListData
            .bind(to: topMentorCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.topMentorCV.dequeueReusableCell(withReuseIdentifier: "TopMentorCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? TopMentorCollectionViewCell {
                    
                    cell.setData(mentor: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        categoryViewModel.output.jobCategoryData
            .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "SearchingCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? SearchingCollectionViewCell {
                    if row == 0 {
                        cell.isSelected = true
                        self.categoryCV.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .init())
                    }
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        mentorListViewModel.output.jobMentorListData
            .bind(to: jobMentorCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.jobMentorCV.dequeueReusableCell(withReuseIdentifier: "JobMentorCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? JobMentorCollectionViewCell {
                    cell.setData(mentor: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        reviewListViewModel.output.reviewListData
            .bind(to: reviewCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.reviewCV.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? ReviewCollectionViewCell {
                    cell.setData(model: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [SearchesDataModel] = []
        if collectionView == categoryCV {
            categoryViewModel.output.jobCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        }
        
        if collectionView == bannerCV {
            return CGSize(width: 340, height: 230)
        } else if collectionView == topMentorCV {
            return CGSize(width: 276, height: 135)
        } else if collectionView == categoryCV {
            return SearchingCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
        } else if collectionView == jobMentorCV {
            return CGSize(width: 156, height: 140)
        } else if collectionView == reviewCV {
            return CGSize(width: 230, height: 234)
        } else {
            return CGSize()
        }
    }
}
