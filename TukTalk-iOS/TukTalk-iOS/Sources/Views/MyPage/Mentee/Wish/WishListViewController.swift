//
//  WishListViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift

class WishListViewController: UIViewController {
    
    //MARK:- Properties
    
    private let viewModel = WishListViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let topView = UIView()
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "찜목록"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let nillImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let nillLabel = UILabel().then {
        $0.text = "작성한 리뷰 내역이 없습니다."
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview()
        }
        
        topView.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        
        topView.addSubview(backBtnLabel)
        backBtnLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backBtn)
            $0.leading.equalTo(backBtn.snp.trailing).offset(4)
        }
        
        view.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(nillImg)
        nillImg.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        grayBackgroundView.addSubview(nillLabel)
        nillLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nillImg.snp.bottom).offset(8)
        }
        
        grayBackgroundView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setCollectionViewUI() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = UIColor.GrayScale.gray5
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(WishListCVCell.self, forCellWithReuseIdentifier: "WishListCVCell")
    }
    
    private func bindingCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.getWishListRequest { status in
            if status != 200 {
                self.collectionView.removeFromSuperview()
            }
        } completion: { response in
            if response.count == 0 {
                self.collectionView.removeFromSuperview()
                return
            }
            self.nillImg.removeFromSuperview()
            self.nillLabel.removeFromSuperview()
            Observable.of(response)
                .bind(to: self.collectionView.rx.items) { (cv, row, item) -> UICollectionViewCell in
                    if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCVCell", for: IndexPath.init(row: row, section: 0)) as? WishListCVCell {
                        cell.setData(mentor: item)
                        return cell
                    }
                    return UICollectionViewCell()
                }
                .disposed(by: self.disposeBag)
            }
        }

}

extension WishListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 135)
    }
}
