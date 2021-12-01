//
//  TagBottomSheetView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/28.
//

import RxSwift

final class TagBottomSheetView: UIViewController {
    
    //MARK:- Properties
    
    private let collectionViewModel = BottomSheetCollectionViewModel()
    lazy var tagViewModel = TagBottomSheetViewModel()
    private let disposeBag = DisposeBag()
    
    let companyTagTitle = BehaviorSubject(value: "")
    let careerTagTitle = BehaviorSubject(value: "")
    let closeBottomSheet = BehaviorSubject(value: false)
    
    //MARK:- UI Components

    private let bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "categoryCloseImg"), for: .normal)
    }
    
    private let closeLabel = UILabel().then {
        $0.text = "태그"
        $0.font = UIFont.TTFont(type: .SDReg, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let resetBtn = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 14)
    }
    
    private let companyLabel = UILabel().then {
        $0.text = "기업"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let companyCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let careerLabel = UILabel().then {
        $0.text = "경력"
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let careerCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let applyBtn = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
        $0.layer.cornerRadius = 26
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray2
    }

    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        applyAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.presentingViewController?.tabBarController?.tabBar.isHidden = false
    }

    //MARK:- Functions

    private func setUI() {
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height-230)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(UIScreen.main.bounds.height)
        }

        bottomSheetView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        bottomSheetView.addSubview(closeLabel)
        closeLabel.snp.makeConstraints {
            $0.bottom.equalTo(closeBtn)
            $0.leading.equalTo(closeBtn.snp.trailing).offset(12)
        }
        
        bottomSheetView.addSubview(resetBtn)
        resetBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(22)
        }
        
        bottomSheetView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(closeBtn.snp.bottom).offset(40)
        }
        
        bottomSheetView.addSubview(companyCV)
        companyCV.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(companyLabel.snp.bottom).offset(12)
            $0.height.equalTo(84)
        }
        
        bottomSheetView.addSubview(careerLabel)
        careerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(companyCV.snp.bottom).offset(32)
        }
        
        bottomSheetView.addSubview(careerCV)
        careerCV.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(careerLabel.snp.bottom).offset(12)
            $0.height.equalTo(84)
        }
        
        bottomSheetView.addSubview(applyBtn)
        applyBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            if UIScreen.main.bounds.height <= 736 {
                $0.bottom.equalToSuperview().inset(16)
            } else {
                $0.bottom.equalToSuperview().inset(46)
            }
            
        }
        
        bottomSheetView.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(applyBtn.snp.top).offset(-12)
        }
    }
    
    private func setCollectionViewUI() {
        let companyCVLayout = UICollectionViewFlowLayout()
        companyCVLayout.minimumLineSpacing = 12
        companyCVLayout.minimumInteritemSpacing = 8
        companyCVLayout.scrollDirection = .vertical
        companyCV.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 23)
        companyCV.setCollectionViewLayout(companyCVLayout, animated: false)
        companyCV.backgroundColor = .white
        companyCV.showsHorizontalScrollIndicator = false
        companyCV.register(BottomSheetCollectionViewCell.self, forCellWithReuseIdentifier: "BottomSheetCollectionViewCell")
        
        let careerCVLayout = UICollectionViewFlowLayout()
        careerCVLayout.minimumLineSpacing = 12
        careerCVLayout.minimumInteritemSpacing = 8
        careerCVLayout.scrollDirection = .vertical
        careerCV.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 67)
        careerCV.setCollectionViewLayout(careerCVLayout, animated: false)
        careerCV.backgroundColor = .white
        careerCV.showsHorizontalScrollIndicator = false
        careerCV.register(BottomSheetCollectionViewCell.self, forCellWithReuseIdentifier: "BottomSheetCollectionViewCell")
    }
    
    private func binding() {
        applyBtn.rx.tap
            .bind { _ in
                self.tagViewModel.output.companyText
                    .bind(to: self.companyTagTitle)
                    .disposed(by: self.disposeBag)
                self.tagViewModel.output.careerText
                    .bind(to: self.careerTagTitle)
                    .disposed(by: self.disposeBag)
                self.closeBottomSheet.onNext(true)
                self.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
        resetBtn.rx.tap
            .bind { _ in
                self.companyCV.allowsSelection = false
                self.companyCV.allowsSelection = true
                self.tagViewModel.input.companyTitle.onNext("")
                self.careerCV.allowsSelection = false
                self.careerCV.allowsSelection = true
                self.tagViewModel.input.careerTitle.onNext("")
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind { _ in
                self.dismiss(animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        companyCV.rx.setDelegate(self).disposed(by: disposeBag)
        careerCV.rx.setDelegate(self).disposed(by: disposeBag)
        collectionViewModel.output.companyListData
            .bind(to: companyCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.companyCV.dequeueReusableCell(withReuseIdentifier: "BottomSheetCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BottomSheetCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    self.tagViewModel.output.companyText.filter { $0 == cell.element.text }
                        .bind { _ in
                            cell.isSelected = true
                            self.companyCV.selectItem(at: IndexPath.init(row: row, section: 0), animated: false, scrollPosition: .init())
                        }.disposed(by: self.disposeBag)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        collectionViewModel.output.careerListData
            .bind(to: careerCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.careerCV.dequeueReusableCell(withReuseIdentifier: "BottomSheetCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BottomSheetCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    self.tagViewModel.output.careerText.filter { $0 == cell.element.text }
                        .bind { _ in
                            cell.isSelected = true
                            self.careerCV.selectItem(at: IndexPath.init(row: row, section: 0), animated: false, scrollPosition: .init())
                        }.disposed(by: self.disposeBag)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        companyCV.rx.modelSelected(SearchesDataModel.self)
            .bind(onNext: {model in
                self.tagViewModel.input.companyTitle.onNext(model.title)
            })
            .disposed(by: disposeBag)
        
        careerCV.rx.modelSelected(SearchesDataModel.self)
            .bind(onNext: {model in
                self.tagViewModel.input.careerTitle.onNext(model.title)
            })
            .disposed(by: disposeBag)
    }
    
    private func applyAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: (-UIScreen.main.bounds.height)+230)
            self.bottomSheetView.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension TagBottomSheetView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [SearchesDataModel] = []
        
        if collectionView == companyCV {
            collectionViewModel.output.companyListData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        } else {
            collectionViewModel.output.careerListData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
        }
        
        return BottomSheetCollectionViewCell.fittingSize(availableHeight: 36, name: items[indexPath.row].title)
    }
}
