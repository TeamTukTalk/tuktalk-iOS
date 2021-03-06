//
//  SearchingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import RxSwift

class SearchingViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var searchCVModel = SearchesCollectionViewModel()
    private lazy var mentorCVModel = MentorListCollectionViewModel()
    private let closeBottomSheet = BehaviorSubject<Bool>(value: false)
    private var categorySelected = false
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    let searchTextBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
    }
    
    private let name = String(data: KeyChain.load(key: "nickname")!, encoding: .utf8)
    
    private let searchTextUnderline = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray1
    }
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let clearBtn = UIButton().then {
        $0.setImage(UIImage(named: "clearImg"), for: .normal)
    }
    
    private let companyCategoryBtn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 6
    }
    private let companyTitleLabel = UILabel().then {
        $0.text = "기업"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub2
    }
    private let companyIcon = UIImageView().then {
        $0.image = UIImage(named: "dropDownImg")
    }
    let companyExtraLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.Primary.primary
    }
    
    private let careerCategoryBtn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 6
    }
    private let careerTitleLabel = UILabel().then {
        $0.text = "경력"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub2
    }
    private let careerIcon = UIImageView().then {
        $0.image = UIImage(named: "dropDownImg")
    }
    let careerExtraLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.Primary.primary
    }
    
    private let mentorListCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextBtn)
        searchTextBtn.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchTextBtn.addSubview(clearBtn)
        clearBtn.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        view.addSubview(searchTextUnderline)
        searchTextUnderline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(searchTextBtn.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(searchTextUnderline.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(companyCategoryBtn)
        companyCategoryBtn.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(73)
            $0.top.equalTo(categoryCV.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(16)
        }
        companyCategoryBtn.addSubview(companyTitleLabel)
        companyTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        companyCategoryBtn.addSubview(companyIcon)
        companyIcon.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        companyCategoryBtn.addSubview(companyExtraLabel)
        companyExtraLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(49)
        }
        
        view.addSubview(careerCategoryBtn)
        careerCategoryBtn.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(73)
            $0.top.equalTo(categoryCV.snp.bottom).offset(11)
            $0.leading.equalTo(companyCategoryBtn.snp.trailing).offset(8)
        }
        careerCategoryBtn.addSubview(careerTitleLabel)
        careerTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        careerCategoryBtn.addSubview(careerIcon)
        careerIcon.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        careerCategoryBtn.addSubview(careerExtraLabel)
        careerExtraLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(49)
        }
        
        view.addSubview(mentorListCV)
        mentorListCV.snp.makeConstraints {
            $0.top.equalTo(companyCategoryBtn.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        mentorListCV.addSubview(devideLineView)
        devideLineView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalToSuperview()
            $0.leading.equalTo(mentorListCV.snp.leading)
            $0.trailing.equalTo(mentorListCV.snp.trailing)
        }
        
        mentorListCV.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setCollectionViewUI() {
        let categoryCVLayout = UICollectionViewFlowLayout()
        categoryCVLayout.minimumLineSpacing = .zero
        categoryCVLayout.minimumInteritemSpacing = 8
        categoryCVLayout.scrollDirection = .horizontal
        categoryCVLayout.sectionInset = .init(top: 5, left: 4, bottom: 5, right: 4)
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        categoryCV.setCollectionViewLayout(categoryCVLayout, animated: false)
        categoryCV.backgroundColor = .white
        categoryCV.showsHorizontalScrollIndicator = false
        categoryCV.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
        let mentorListCVLayout = UICollectionViewFlowLayout()
        mentorListCVLayout.minimumLineSpacing = 8
        mentorListCVLayout.minimumInteritemSpacing = .zero
        mentorListCVLayout.scrollDirection = .vertical
        mentorListCVLayout.sectionInset = .init(top: 62, left: 0, bottom: 16, right: 0)
        mentorListCV.setCollectionViewLayout(mentorListCVLayout, animated: false)
        mentorListCV.backgroundColor = .white
        mentorListCV.showsVerticalScrollIndicator = false
        mentorListCV.register(TopMentorCollectionViewCell.self, forCellWithReuseIdentifier: "TopMentorCollectionViewCell")
    }
    
    private func binding() {
        searchTextBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(SearchDirectViewController(), animated: false)
            }
            .disposed(by: disposeBag)
        
        clearBtn.rx.tap
            .bind {
                self.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        companyCategoryBtn.rx.tap
            .bind {
                self.openBottomSheet()
            }
            .disposed(by: disposeBag)
        
        careerCategoryBtn.rx.tap
            .bind {
                self.openBottomSheet()
            }
            .disposed(by: disposeBag)
        
        categoryCV.rx.modelSelected(SearchesDataModel.self)
            .bind { model in
                self.categorySelected = true
                self.mentorCVModel.subSpecialty = model.title
                self.titleLabel.text = "\(self.name!)님을 도와줄 멘토를 만나보세요!☺️"
                self.mentorCVModel.getSearchMentorList(query: self.searchTextBtn.titleLabel?.text ?? "", companySize: self.companyExtraLabel.text, subSpecialty: model.title, startYear: self.careerExtraLabel.text) { response in
                    self.mentorCVModel.mentorDataList.onNext(response)
                }
            }
            .disposed(by: disposeBag)
        
        mentorListCV.rx.modelSelected(TopMentorSearchResponseElement.self)
            .bind { model in
                let nextVC = MentorInformationViewController()
                nextVC.mentorID = model.mentorID
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func openBottomSheet() {
        self.tabBarController?.tabBar.isHidden = true
        let bottomSheet = TagBottomSheetView()
        
        if companyExtraLabel.text != "" {
            bottomSheet.tagViewModel.input.companyTitle.onNext(companyExtraLabel.text ?? "")
            bottomSheet.companyTagTitle.onNext(companyExtraLabel.text ?? "")
            self.mentorCVModel.companySize = nil
        }
        if careerExtraLabel.text != "" {
            bottomSheet.tagViewModel.input.careerTitle.onNext(careerExtraLabel.text ?? "")
            bottomSheet.careerTagTitle.onNext(careerExtraLabel.text ?? "")
            self.mentorCVModel.startYear = nil
        }
        
        let naviVC = UINavigationController(rootViewController: bottomSheet)
        naviVC.modalPresentationStyle = .overCurrentContext
        naviVC.navigationBar.isHidden = true
        bottomSheet.companyTagTitle
            .filter {!$0.isEmpty}
            .bind { text in
                self.companyExtraLabel.text = text
                self.companyCategoryBtn.snp.updateConstraints {
                    $0.width.equalTo(text.count == 3 ? 118 : 130)
                }
                self.mentorCVModel.companySize = text
                self.titleLabel.text = "\(self.name!)님을 도와줄 멘토를 만나보세요!☺️"
            }
            .disposed(by: self.disposeBag)
        bottomSheet.careerTagTitle
            .filter {!$0.isEmpty}
            .bind { text in
                self.careerExtraLabel.text = text
                self.careerCategoryBtn.snp.updateConstraints {
                    $0.width.equalTo(text.count == 4 ? 118 : 130)
                }
                self.mentorCVModel.startYear = String(text.prefix(1))
                self.titleLabel.text = "\(self.name!)님을 도와줄 멘토를 만나보세요!☺️"
            }
            .disposed(by: self.disposeBag)
        bottomSheet.companyTagTitle
            .filter {$0.isEmpty}
            .bind { text in
                self.companyExtraLabel.text = text
                self.mentorCVModel.companySize = nil
                if self.companyExtraLabel.text == text && self.careerExtraLabel.text == text && !self.categorySelected {
                    self.titleLabel.text = "관심 분야의 멘토와 포트폴리오를 찾아보세요!"
                    self.mentorCVModel.companySize = nil
                    self.mentorCVModel.startYear = nil
                }
                self.companyCategoryBtn.snp.updateConstraints {
                    $0.width.equalTo(73)
                }
            }
            .disposed(by: self.disposeBag)
        bottomSheet.careerTagTitle
            .filter {$0.isEmpty}
            .bind { text in
                self.careerExtraLabel.text = text
                self.mentorCVModel.startYear = nil
                if self.companyExtraLabel.text == text && self.careerExtraLabel.text == text && !self.categorySelected {
                    self.titleLabel.text = "관심 분야의 멘토와 포트폴리오를 찾아보세요!"
                    self.mentorCVModel.companySize = nil
                    self.mentorCVModel.startYear = nil
                }
                self.careerCategoryBtn.snp.updateConstraints {
                    $0.width.equalTo(73)
                }
            }
            .disposed(by: self.disposeBag)
        bottomSheet.closeBottomSheet
            .filter {$0}
            .bind { _ in
                self.reloadMentorData()
            }
            .disposed(by: self.disposeBag)
        self.present(naviVC, animated: false)
    }
    
    private func bindingCollectionView() {
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        mentorListCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        if searchTextBtn.titleLabel?.text == "디자인" {
            self.mentorCVModel.query = "디자인"
            self.reloadMentorData()
            searchCVModel.output.designCategoryData
                .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                    if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? CategoryCollectionViewCell {
                        
                        cell.configure(name: item.title)
                        return cell
                    }
                    return UICollectionViewCell()
                }
                .disposed(by: disposeBag)
        } else if searchTextBtn.titleLabel?.text == "IT/개발" {
            self.mentorCVModel.query = "IT/개발"
            self.reloadMentorData()
            searchCVModel.output.itDevCategoryData
                .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                    if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? CategoryCollectionViewCell {
                        
                        cell.configure(name: item.title)
                        return cell
                    }
                    return UICollectionViewCell()
                }
                .disposed(by: disposeBag)
        }
        
        //        mentorCVModel.output.searchingMentorListData
        //            .bind(to: mentorListCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
        //                if let cell = self.mentorListCV.dequeueReusableCell(withReuseIdentifier: "MentorListCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? MentorListCollectionViewCell {
        //
        //                    cell.setData(mentor: item)
        //                    return cell
        //                }
        //                return UICollectionViewCell()
        //            }
        //            .disposed(by: disposeBag)
        mentorCVModel.mentorDataList
            .bind(to: self.mentorListCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.mentorListCV.dequeueReusableCell(withReuseIdentifier: "TopMentorCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? TopMentorCollectionViewCell {
                    cell.setData(mentor: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func reloadMentorData() {
        self.mentorCVModel.getSearchMentorList(query: self.mentorCVModel.query!, companySize: self.mentorCVModel.companySize, subSpecialty: self.mentorCVModel.subSpecialty, startYear: self.mentorCVModel.startYear) { response in
            self.mentorCVModel.mentorDataList.onNext(response)
        }
    }
}

extension SearchingViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mentorListCV {
            if scrollView.contentOffset.y > 0 {
                devideLineView.snp.updateConstraints {
                    $0.top.equalTo(scrollView.contentOffset.y)
                    $0.height.equalTo(max(6-scrollView.contentOffset.y, 1))
                }
                devideLineView.backgroundColor = UIColor.GrayScale.gray3
            } else {
                devideLineView.snp.updateConstraints {
                    $0.top.equalTo(0)
                    $0.height.equalTo(6)
                }
                devideLineView.backgroundColor = UIColor.GrayScale.gray5
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [SearchesDataModel] = []
        
        if searchTextBtn.titleLabel?.text == "디자인" {
            searchCVModel.output.designCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        } else if searchTextBtn.titleLabel?.text == "IT/개발" {
            searchCVModel.output.itDevCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        }
        
        if collectionView == mentorListCV {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 135)
        } else {
            return CategoryCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
        }
    }
}
