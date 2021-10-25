//
//  SearchDirectViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit
import RxSwift

class SearchDirectViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    private let collectionViewModel = RecentSearchesViewModel()
    
    //MARK:- UI Components
    
    let searchTextField = UITextField().then {
        $0.placeholder = "멘토, 직무 검색"
        $0.setLeftPaddingPoints(32)
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
        $0.becomeFirstResponder()
    }
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 24
        $0.frame.size.width = 24
    }
    
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "searchImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let recentSearchCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let subTitleLabel = UILabel().then {
        $0.text = "뚝딱이 추천하는 검색어"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        searchTextField.addSubview(searchBtn)
        searchTextField.addSubview(backBtn)
        searchBtn.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.height.width.equalTo(12)
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().offset(6)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(recentSearchCV)
        recentSearchCV.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(recentSearchCV.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setCollectionViewUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 5, left: 4, bottom: 5, right: 4)
        recentSearchCV.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        recentSearchCV.setCollectionViewLayout(flowLayout, animated: false)
        recentSearchCV.backgroundColor = .white
        recentSearchCV.showsHorizontalScrollIndicator = false
        recentSearchCV.register(SearchDirectCollectionViewCell.self, forCellWithReuseIdentifier: "SearchDirectCollectionViewCell")
    }
    
    private func binding() {
        searchTextField.rx.text
            .bind { text in
                print(text!)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        recentSearchCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionViewModel.output.collectionData
            .bind(to: recentSearchCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.recentSearchCV.dequeueReusableCell(withReuseIdentifier: "SearchDirectCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? SearchDirectCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension SearchDirectViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [RecentSearchesDataModel] = []
        
        collectionViewModel.output.collectionData
            .subscribe(onNext: {data in
                items = data
            })
            .disposed(by: disposeBag)
        
        return SearchDirectCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
    }
}
