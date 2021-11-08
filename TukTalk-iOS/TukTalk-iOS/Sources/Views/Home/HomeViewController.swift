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
    private lazy var topMentorViewModel = MentorListCollectionViewModel()
    private lazy var categoryViewModel = SearchesCollectionViewModel()
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

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1600)
    }
    
    //MARK:- Function
    
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
            $0.width.height.equalToSuperview()
            $0.edges.equalToSuperview()
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
    }
    
    private func binding() {
        //TODO
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
        jobMentorCVLayout.minimumInteritemSpacing = 8
        jobMentorCVLayout.scrollDirection = .horizontal
        jobMentorCV.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        jobMentorCV.setCollectionViewLayout(jobMentorCVLayout, animated: false)
        jobMentorCV.backgroundColor = .white
        jobMentorCV.showsHorizontalScrollIndicator = false
        
        
    }
    
    private func bindingCollectionView() {
        bannerCV.rx.setDelegate(self).disposed(by: disposeBag)
        topMentorCV.rx.setDelegate(self).disposed(by: disposeBag)
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)

        bannerViewModel.output.bannerListData
            .bind(to: bannerCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.bannerCV.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BannerCollectionViewCell {
                    
                    cell.setData(img: item.image)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        topMentorViewModel.output.topMentorListData
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

                    cell.configure(name: item.title)
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
        } else {
            return CGSize()
        }
    }
}
