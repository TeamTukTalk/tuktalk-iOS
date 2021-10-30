//
//  MentorListCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/29.
//

import UIKit
import RxSwift

class MentorListCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate {
    private let hashTagListViewModel = HashTagCollectionViewModel()
    private let disposeBag = DisposeBag()
    
    var profileImg = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
    }
    var nameLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    let mentorConfirmImg = UIImageView().then {
        $0.image = UIImage(named: "mentorConfirmImg")
    }
    var companyLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    var jobLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    let devideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    
    let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    var hashTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setCollectionViewUI()
        bindingCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setCollectionViewUI()
        bindingCollectionView()
    }
    
    func setData(mentor: MentorListDataModel) {
        profileImg.image = mentor.image
        nameLabel.text = mentor.name
        companyLabel.text = mentor.company
        jobLabel.text = mentor.job
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray3.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        contentView.addSubview(profileImg)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(devideDot)
        contentView.addSubview(devideView)
        contentView.addSubview(hashTagCV)
        
        profileImg.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.leading.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImg.snp.trailing).offset(16)
            make.top.equalTo(profileImg.snp.top)
        }
        mentorConfirmImg.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        devideDot.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.top.equalTo(companyLabel.snp.top)
            make.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints { make in
            make.leading.equalTo(devideDot.snp.trailing).offset(6)
            make.top.equalTo(companyLabel)
        }
        devideView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(profileImg.snp.trailing).offset(16)
            make.top.equalTo(companyLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
        hashTagCV.snp.makeConstraints { make in
            make.top.equalTo(devideView.snp.bottom).offset(8)
            make.leading.equalTo(profileImg.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(37)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    private func setCollectionViewUI() {
        let hashTagCVLayout = UICollectionViewFlowLayout()
        hashTagCVLayout.minimumLineSpacing = 2
        hashTagCVLayout.minimumInteritemSpacing = 4
        hashTagCVLayout.scrollDirection = .vertical
        hashTagCV.setCollectionViewLayout(hashTagCVLayout, animated: false)
        hashTagCV.backgroundColor = .white
        hashTagCV.showsHorizontalScrollIndicator = false
        hashTagCV.register(HashTagCollectionViewCell.self, forCellWithReuseIdentifier: "HashTagCollectionViewCell")
    }
    private func bindingCollectionView() {
        hashTagCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        hashTagListViewModel.output.hashTagListData
            .bind(to: hashTagCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.hashTagCV.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? HashTagCollectionViewCell {
                    
                    cell.configure(name: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension MentorListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [SearchesDataModel] = []
        
        hashTagListViewModel.output.hashTagListData
            .subscribe(onNext: {data in
                items = data
            })
            .disposed(by: disposeBag)
        
        return HashTagCollectionViewCell.fittingSize(availableHeight: 18, name: items[indexPath.row].title)
    }
}
