//
//  SearchingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import UIKit
import RxSwift

class SearchingViewController: UIViewController {
    
    //MARK:- Properties
    
    private let searchingViewModel = SearchesCollectionViewModel()
    private let disposeBag = DisposeBag()

    //MARK:- UI Components
    
    let searchTextBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
    }
    
    private let searchTextUnderline = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray1
    }
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsMultipleSelection = true
    }
    
    private let clearBtn = UIButton().then {
        $0.setImage(UIImage(named: "clearImg"), for: .normal)
    }
    
    private let companyCategoryBtn = UIButton().then {
        $0.setTitle("기업", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.setImage(UIImage(named: "dropDownImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 6
        $0.titleEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 32)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 45, bottom: 10, right: 12)
    }
    
    private let careerCategoryBtn = UIButton().then {
        $0.setTitle("경력", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.setImage(UIImage(named: "dropDownImg"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 6
        $0.titleEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 32)
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 45, bottom: 10, right: 12)
    }
    
    private let devideLineView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "관심 분야의 멘토와 포트폴리오를 찾아보세요!"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    //MARK:- Life cycle
    
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
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextBtn)
        searchTextBtn.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(64)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        searchTextBtn.addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(searchTextUnderline)
        searchTextUnderline.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(searchTextBtn.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(categoryCV)
        categoryCV.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(searchTextUnderline.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(companyCategoryBtn)
        companyCategoryBtn.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(73)
            make.top.equalTo(categoryCV.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(careerCategoryBtn)
        careerCategoryBtn.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(73)
            make.top.equalTo(categoryCV.snp.bottom).offset(11)
            make.leading.equalTo(companyCategoryBtn.snp.trailing).offset(8)
        }
        
        view.addSubview(devideLineView)
        devideLineView.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.top.equalTo(companyCategoryBtn.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(devideLineView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setCollectionViewUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 5, left: 4, bottom: 5, right: 4)
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        categoryCV.setCollectionViewLayout(flowLayout, animated: false)
        categoryCV.backgroundColor = .white
        categoryCV.showsHorizontalScrollIndicator = false
        categoryCV.register(SearchingCollectionViewCell.self, forCellWithReuseIdentifier: "SearchingCollectionViewCell")
    }
    
    private func binding() {
        searchTextBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(SearchDirectViewController(), animated: false)
            }
            .disposed(by: disposeBag)
        
        clearBtn.rx.tap
            .bind { _ in
                self.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        companyCategoryBtn.rx.tap
            .bind { _ in
                let bottomSheet = TagBottomSheetView()
                let naviVC = UINavigationController(rootViewController: bottomSheet)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)

        if searchTextBtn.titleLabel?.text == "디자인" {
            searchingViewModel.output.designCategoryData
                .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                    if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "SearchingCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? SearchingCollectionViewCell {

                        cell.configure(name: item.title)
                        return cell
                    }
                    return UICollectionViewCell()
                }
                .disposed(by: disposeBag)
        } else if searchTextBtn.titleLabel?.text == "IT/개발" {
            searchingViewModel.output.itDevCategoryData
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
}

extension SearchingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [SearchesDataModel] = []

        if searchTextBtn.titleLabel?.text == "디자인" {
            searchingViewModel.output.designCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        } else if searchTextBtn.titleLabel?.text == "IT/개발" {
            searchingViewModel.output.itDevCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        }
        
        return SearchingCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
    }
}
