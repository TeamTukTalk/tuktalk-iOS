//
//  TopMentorCollectionViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/08.
//

import RxSwift
import RxCocoa

class TopMentorCollectionViewCell: UICollectionViewCell {
    private let disposeBag = DisposeBag()
    var hashTag = BehaviorSubject<[HashTag]>(value: [])
    
    var profileImg = UIImageView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 22
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    var profileBackground = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 22
    }
    var profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
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
    
    func setData(mentor: TopMentorSearchResponseElement) {
        if mentor.profileImageURL == "" {
            profileBackground.isHidden = false
            profileLabel.isHidden = false
            profileBackground.backgroundColor = UIColor.Profile.getProfileColor(color: mentor.profileImageColor)
            profileLabel.textColor = UIColor.Profile.getNameColor(color: mentor.profileImageColor)
            profileLabel.text = mentor.firstLetter
            profileImg.isHidden = true
        } else {
            let url = URL(string: mentor.profileImageURL)
            let data = try? Data(contentsOf: url!)
            profileImg.image = UIImage(data: data!)
            profileImg.isHidden = false
            profileBackground.isHidden = true
            profileLabel.isHidden = true
        }
        nameLabel.text = mentor.nickname
        companyLabel.text = mentor.companyName
        jobLabel.text = mentor.department
        hashTag.onNext(mentor.hashTags)
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.GrayScale.gray3.cgColor
        layer.cornerRadius = 8
        layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        contentView.addSubview(profileImg)
        contentView.addSubview(profileBackground)
        profileBackground.addSubview(profileLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mentorConfirmImg)
        contentView.addSubview(companyLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(devideDot)
        contentView.addSubview(devideView)
        contentView.addSubview(hashTagCV)
        
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        profileBackground.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview().inset(20)
        }
        profileLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.equalTo(profileImg.snp.trailing).offset(12)
            $0.top.equalTo(profileImg.snp.top)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalTo(nameLabel).offset(1)
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(profileImg.snp.trailing).offset(12)
        }
        devideDot.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints {
            $0.leading.equalTo(devideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(profileImg.snp.trailing).offset(12)
            $0.top.equalTo(companyLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        hashTagCV.snp.makeConstraints {
            $0.top.equalTo(devideView.snp.bottom).offset(8)
            $0.leading.equalTo(profileImg.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(27)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    private func setCollectionViewUI() {
        let hashTagCVLayout = LeftAlignedCollectionViewFlowLayout()
        hashTagCVLayout.minimumLineSpacing = 2
        hashTagCVLayout.minimumInteritemSpacing = 4
        hashTagCVLayout.scrollDirection = .vertical
        hashTagCV.setCollectionViewLayout(hashTagCVLayout, animated: false)
        hashTagCV.backgroundColor = .white
        hashTagCV.showsHorizontalScrollIndicator = false
        hashTagCV.isUserInteractionEnabled = false
        hashTagCV.register(HashTagCollectionViewCell.self, forCellWithReuseIdentifier: "HashTagCollectionViewCell")
    }
    private func bindingCollectionView() {
        hashTagCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        hashTag
            .bind(to: hashTagCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.hashTagCV.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? HashTagCollectionViewCell {
                    
                    cell.configure(name: item.hashTag)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension TopMentorCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var value = CGSize()
        
        hashTag
            .bind { data in
                if indexPath.row < data.count {
                    value = HashTagCollectionViewCell.fittingSize(availableHeight: 18, name: data[indexPath.row].hashTag)
                }
            }
            .disposed(by: disposeBag)
        
        return value
    }
}
