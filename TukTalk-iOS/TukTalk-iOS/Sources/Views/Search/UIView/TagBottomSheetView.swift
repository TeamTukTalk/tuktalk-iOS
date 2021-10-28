//
//  TagBottomSheetView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/28.
//

import UIKit
import RxSwift

final class TagBottomSheetView: UIViewController {
    
    //MARK:- Properties
    
    private let collectionViewModel = BottomSheetCollectionViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components

    private let bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "categoryCloseImg"), for: .normal)
        $0.addTarget(self, action: #selector(dismissBtnAction), for: .touchUpInside)
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
        bottomSheetView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height-230)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIScreen.main.bounds.height)
        }

        bottomSheetView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        bottomSheetView.addSubview(closeLabel)
        closeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(closeBtn)
            make.leading.equalTo(closeBtn.snp.trailing).offset(12)
        }
        
        bottomSheetView.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(22)
        }
        
        bottomSheetView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(closeBtn.snp.bottom).offset(40)
        }
        
        bottomSheetView.addSubview(companyCV)
        companyCV.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(companyLabel.snp.bottom).offset(12)
            make.height.equalTo(84)
        }
        
        bottomSheetView.addSubview(careerLabel)
        careerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(companyCV.snp.bottom).offset(32)
        }
        
        bottomSheetView.addSubview(careerCV)
        careerCV.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(careerLabel.snp.bottom).offset(12)
            make.height.equalTo(84)
        }
        
        bottomSheetView.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(46)
        }
        
        bottomSheetView.addSubview(devideView)
        devideView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(applyBtn.snp.top).offset(-12)
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
    
    private func bindingCollectionView() {
        companyCV.rx.setDelegate(self).disposed(by: disposeBag)
        careerCV.rx.setDelegate(self).disposed(by: disposeBag)
        collectionViewModel.output.companyListData
            .bind(to: companyCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.companyCV.dequeueReusableCell(withReuseIdentifier: "BottomSheetCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BottomSheetCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        collectionViewModel.output.careerListData
            .bind(to: careerCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.careerCV.dequeueReusableCell(withReuseIdentifier: "BottomSheetCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? BottomSheetCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func applyAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: (-UIScreen.main.bounds.height)+230)
            self.bottomSheetView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func dismissBtnAction() {
        self.dismiss(animated: false)
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
