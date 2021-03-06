//
//  RegistProfileFifthViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift
import RxCocoa

class RegistProfileFifthViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var collectionViewModel = TagCollectionViewModel()
    private lazy var viewModel = RegistMentorFifthViewModel()
    private let disposeBag = DisposeBag()
    private let progressPercentValue = BehaviorRelay(value: Float(1))
    private var hashTagSelectedNumber = 0
    private let progressIsHiddenValue = BehaviorRelay(value: false)
    var progressPercent: Observable<Float> {
        return progressPercentValue.asObservable()
    }
    var progressIsHidden: Observable<Bool> {
        return progressIsHiddenValue.asObservable()
    }
    
    //MARK:- UI Components
    
    private let backBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.setTitle("프로필 등록/수정", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -15)
    }
    
    private let closeBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "뚝닥 멘티들이 많이 찾을 수 있도록\n해시태그를 선택해주세요 💬"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 17)
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "* 최대 8개까지 선택 가능합니다."
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub3
    }
    
    private let companyLabel = UILabel().then {
        $0.text = "기업*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let companyCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let hashTagLabel = UILabel().then {
        $0.text = "추천 해시태그*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let hashTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 26
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setNaviBar() {
        let leftBarButton = UIBarButtonItem(customView: backBtn)
        let rightBarButton = UIBarButtonItem(customView: closeBtn)
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalToSuperview().offset(114)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(companyCV)
        companyCV.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(companyLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(hashTagLabel)
        hashTagLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(companyCV.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(hashTagCV)
        hashTagCV.snp.makeConstraints {
            $0.top.equalTo(hashTagLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(19)
            $0.bottom.equalTo(nextBtn.snp.top).offset(-12)
        }
    }
    
    private func setCollectionViewUI() {
        let companyCVflowLayout = UICollectionViewFlowLayout()
        companyCVflowLayout.minimumLineSpacing = .zero
        companyCVflowLayout.minimumInteritemSpacing = 8
        companyCVflowLayout.scrollDirection = .horizontal
        companyCV.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        companyCV.setCollectionViewLayout(companyCVflowLayout, animated: false)
        companyCV.backgroundColor = .white
        companyCV.showsHorizontalScrollIndicator = false
        companyCV.register(CompanyCollectionViewCell.self, forCellWithReuseIdentifier: "CompanyCollectionViewCell")
        
        let hashTagCVflowLayout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        hashTagCVflowLayout.minimumLineSpacing = 12
        hashTagCVflowLayout.minimumInteritemSpacing = 8
        hashTagCVflowLayout.scrollDirection = .vertical
        hashTagCV.setCollectionViewLayout(hashTagCVflowLayout, animated: false)
        hashTagCV.backgroundColor = .white
        hashTagCV.showsHorizontalScrollIndicator = false
        hashTagCV.allowsMultipleSelection = true
        hashTagCV.register(RecommendHashTagCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendHashTagCollectionViewCell")
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind {
                self.progressPercentValue.accept(0.8)
                self.navigationController?.popViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind {
                let popUpViewController = PopUpViewController()
                popUpViewController.popUpTitleLabel.text = "프로필 등록을 중단하시겠습니까?"
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.view.endEditing(true)
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            }
            .disposed(by: disposeBag)
        
        companyCV.rx.modelSelected(TagCollectionViewDataModel.self)
            .bind { model in
                self.viewModel.input.companySelected.onNext(true)
                self.viewModel.company = model.title
            }
            .disposed(by: disposeBag)
        
        hashTagCV.rx.itemSelected
            .bind { index in
                if self.hashTagSelectedNumber == 8 {
                    self.hashTagCV.deselectItem(at: index, animated: false)
                    return
                }
                self.hashTagSelectedNumber += 1
                self.viewModel.hashTag.append(self.collectionViewModel.hashTagCategoryList[index.last!].title)
                self.viewModel.input.hashTagSelected.onNext(self.hashTagSelectedNumber)
            }
            .disposed(by: disposeBag)
        
        hashTagCV.rx.itemDeselected
            .bind { index in
                self.hashTagSelectedNumber -= 1
                self.viewModel.hashTag = self.viewModel.hashTag.filter() {$0 != self.collectionViewModel.hashTagCategoryList[index.last!].title}
                self.viewModel.input.hashTagSelected.onNext(self.hashTagSelectedNumber)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nextBtnEnable
            .drive(onNext: { status in
                self.nextBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
                self.nextBtn.isEnabled = status
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .bind { _ in
                let nextVC = RegistProfileFinishViewController()
                nextVC.progressIsHidden.subscribe(onNext: { valid in
                    self.progressIsHiddenValue.accept(valid)
                })
                .disposed(by: self.disposeBag)
                
                UserMentorRegist.shared.companySize = self.viewModel.company?.trimmingCharacters(in: ["#"])
                
                var hashTag: [HashTag] = []
                for i in Range(0...self.viewModel.hashTag.count - 1) {
                    hashTag.append(HashTag(hashTag: self.viewModel.hashTag[i].trimmingCharacters(in: ["#"])))
                }
                let user = UserMentorRegist.shared
                let career = Career(months: user.months!, years: user.years!)
                let param = RegistMentorRequest(nickname: user.nickname!, simpleIntroduction: user.simpleIntroDuction!, detailedIntroduction: user.detailedIntroduction!, specialty: user.specialty!, subSpecialties: user.subSpecialties, companyName: user.companyName!, department: user.department!, position: user.position!, career: career, careerDescription: user.careerDescription!, companySize: user.companySize!, hashTags: hashTag)
                self.viewModel.registProfile(param: param) { response in
                    print(response.mentorId)
                    self.navigationController?.pushViewController(nextVC, animated: false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        companyCV.rx.setDelegate(self).disposed(by: disposeBag)
        hashTagCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionViewModel.output.companyCategoryData
            .bind(to: companyCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.companyCV.dequeueReusableCell(withReuseIdentifier: "CompanyCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? CompanyCollectionViewCell {

                    cell.configure(title: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        collectionViewModel.output.hashTagCategoryData
            .bind(to: hashTagCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.hashTagCV.dequeueReusableCell(withReuseIdentifier: "RecommendHashTagCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? RecommendHashTagCollectionViewCell {

                    cell.configure(title: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension RegistProfileFifthViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [TagCollectionViewDataModel] = []
        
        switch collectionView {
        case companyCV:
            collectionViewModel.output.companyCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
            
            return CompanyCollectionViewCell.fittingSize(availableHeight: 36, title: items[indexPath.row].title)
        case hashTagCV:
            collectionViewModel.output.hashTagCategoryData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
            
            return RecommendHashTagCollectionViewCell.fittingSize(availableHeight: 36, title: items[indexPath.row].title)
        default:
            return CGSize()
        }
    }
}
