//
//  JobMentorListViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/10.
//

import RxSwift

class JobMentorListViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var categoryViewModel = SearchesCollectionViewModel()
    private lazy var mentorListViewModel = MentorListCollectionViewModel()
    private let disposeBag = DisposeBag()
    var category: Int?
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "직무별 뚝딱멘토"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let mentorListCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
        setCollectionViewUI()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.top.equalTo(categoryCV.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(mentorListCV)
        mentorListCV.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setCollectionViewUI() {
        let categoryCVLayout = UICollectionViewFlowLayout()
        categoryCVLayout.minimumInteritemSpacing = 8
        categoryCVLayout.scrollDirection = .horizontal
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
        categoryCV.setCollectionViewLayout(categoryCVLayout, animated: false)
        categoryCV.backgroundColor = .white
        categoryCV.showsHorizontalScrollIndicator = false
        categoryCV.register(SearchingCollectionViewCell.self, forCellWithReuseIdentifier: "SearchingCollectionViewCell")
        
        let mentorListCVLayout = UICollectionViewFlowLayout()
        mentorListCVLayout.minimumLineSpacing = 8
        mentorListCVLayout.minimumInteritemSpacing = .zero
        mentorListCVLayout.scrollDirection = .vertical
        mentorListCVLayout.sectionInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        mentorListCV.setCollectionViewLayout(mentorListCVLayout, animated: false)
        mentorListCV.backgroundColor = UIColor.GrayScale.gray5
        mentorListCV.showsVerticalScrollIndicator = false
        mentorListCV.register(MentorListCollectionViewCell.self, forCellWithReuseIdentifier: "MentorListCollectionViewCell")
    }
    
    private func bindingCollectionView() {
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        mentorListCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        categoryViewModel.output.jobCategoryData
            .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "SearchingCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? SearchingCollectionViewCell {
                    if row == self.category {
                        cell.isSelected = true
                        self.categoryCV.selectItem(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .init())
                    }
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        mentorListViewModel.output.searchingMentorListData
            .bind(to: mentorListCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.mentorListCV.dequeueReusableCell(withReuseIdentifier: "MentorListCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? MentorListCollectionViewCell {
                    
                    cell.setData(mentor: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension JobMentorListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case categoryCV:
            var items: [SearchesDataModel] = []
            categoryViewModel.output.jobCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
            return SearchingCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
        case mentorListCV:
            return CGSize(width: 343, height: 135)
        default:
            return CGSize()
        }
    }
}
