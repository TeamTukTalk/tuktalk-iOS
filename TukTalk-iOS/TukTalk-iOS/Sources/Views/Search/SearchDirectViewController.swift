//
//  SearchDirectViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import RxSwift

class SearchDirectViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
//    private lazy var collectionViewModel = SearchesCollectionViewModel()
    private lazy var viewModel = SearchDirectViewModel()
    private var nextText = ""
    
    //MARK:- UI Components
    
    let searchTextField = UITextField().then {
        $0.placeholder = "멘토, 직무 검색"
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let searchTextUnderline = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray1
    }
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "searchImg"), for: .normal)
    }
    
//    private let titleLabel = UILabel().then {
//        $0.text = "최근 검색어"
//        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
//        $0.textColor = UIColor.GrayScale.normal
//    }
//
//    private let recentSearchCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let subTitleLabel = UILabel().then {
        $0.text = "뚝딱이 추천하는 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let recommendView = RecommendView()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        setCollectionViewUI()
        binding()
//        bindingCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        searchTextField.becomeFirstResponder()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchBtn)
        searchBtn.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalToSuperview().offset(66)
            $0.trailing.equalToSuperview().inset(16)
        }

        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.height.width.equalTo(12)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(68)
        }
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalTo(backBtn.snp.trailing).offset(8)
            $0.trailing.equalTo(searchBtn.snp.leading)
        }
        
        view.addSubview(searchTextUnderline)
        searchTextUnderline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(searchTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
//        view.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(searchTextField.snp.bottom).offset(32)
//            $0.leading.equalToSuperview().offset(16)
//        }
//
//        view.addSubview(recentSearchCV)
//        recentSearchCV.snp.makeConstraints {
//            $0.height.equalTo(50)
//            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
//            $0.leading.trailing.equalToSuperview()
//        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(recommendView)
        recommendView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setCollectionViewUI() {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = .zero
//        flowLayout.minimumInteritemSpacing = 8
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.sectionInset = .init(top: 5, left: 4, bottom: 5, right: 4)
//        recentSearchCV.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
//        recentSearchCV.setCollectionViewLayout(flowLayout, animated: false)
//        recentSearchCV.backgroundColor = .white
//        recentSearchCV.showsHorizontalScrollIndicator = false
//        recentSearchCV.register(SearchDirectCollectionViewCell.self, forCellWithReuseIdentifier: "SearchDirectCollectionViewCell")
    }
    
    private func binding() {
        
        searchTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        viewModel.output.resultText
            .bind { text in
                self.nextText = text
            }
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind {
                let nextVC = SearchingDirectViewController()
                nextVC.searchTextBtn.setTitle(self.nextText, for: .normal)
                nextVC.searchTextBtn.setTitleColor(UIColor.GrayScale.normal, for: .normal)
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
        
        searchBtn.rx.tap
            .bind {
                let nextVC = SearchingDirectViewController()
                nextVC.searchTextBtn.setTitle(self.nextText, for: .normal)
                nextVC.searchTextBtn.setTitleColor(UIColor.GrayScale.normal, for: .normal)
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
//        recentSearchCV.rx.setDelegate(self).disposed(by: disposeBag)
//
//        collectionViewModel.output.recentSearchesData
//            .bind(to: recentSearchCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
//                if let cell = self.recentSearchCV.dequeueReusableCell(withReuseIdentifier: "SearchDirectCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? SearchDirectCollectionViewCell {
//
//                    cell.configure(name: item.title)
//                    return cell
//                }
//                return UICollectionViewCell()
//            }
//            .disposed(by: disposeBag)
    }
}

extension SearchDirectViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        var items: [SearchesDataModel] = []
//        
//        collectionViewModel.output.recentSearchesData
//            .subscribe(onNext: {data in
//                items = data
//            })
//            .disposed(by: disposeBag)
//        
//        return SearchDirectCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
//    }
}
