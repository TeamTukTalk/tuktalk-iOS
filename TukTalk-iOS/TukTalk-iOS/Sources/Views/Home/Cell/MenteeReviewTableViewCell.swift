//
//  ReviewTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/18.
//

import RxSwift

class MenteeReviewTableViewCell: UITableViewCell {
    
    public static let identifier : String = "MenteeReviewTableViewCell"
    
    let profileBtn = UIButton()
    
    let cellBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let viewMoreBtn = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 10)
    }
    
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
    let mentorDevideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    var jobLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub1
    }
    var starImageView = UIImageView()
    var contentsLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub1
    }
    var menteeNameLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.GrayScale.sub3
    }
    let menteeDevideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    var reviewDateLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.GrayScale.sub3
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model: ReviewDataModel) {
        profileImg.image = model.image
        nameLabel.text = model.name
        companyLabel.text = model.company
        jobLabel.text = model.job
        starImageView.image = model.star
        contentsLabel.text = model.contents
        menteeNameLabel.text = model.menteeName
        reviewDateLabel.text = model.date
    }
    
    func viewMoreBtnAction() {
        switch contentsLabel.numberOfLines {
        case 3:
            contentsLabel.numberOfLines = 0
            viewMoreBtn.setImage(UIImage(named: "dropUpBlackImg"), for: .normal)
        default:
            contentsLabel.numberOfLines = 3
            viewMoreBtn.setImage(UIImage(named: "dropDownBlackImg"), for: .normal)
        }
    }
    
    private func setUI() {
        backgroundColor = UIColor.GrayScale.gray5
        
        cellBackgroundView.layer.borderWidth = 1
        cellBackgroundView.layer.borderColor = UIColor.GrayScale.gray4.cgColor
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.layer.applyShadow(color: .black, alpha: 0.06, x: 4, y: 4, blur: 24, spread: 0)
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        cellBackgroundView.addSubview(profileBtn)
        profileBtn.addSubview(profileImg)
        profileBtn.addSubview(nameLabel)
        profileBtn.addSubview(mentorConfirmImg)
        profileBtn.addSubview(companyLabel)
        profileBtn.addSubview(jobLabel)
        profileBtn.addSubview(mentorDevideDot)
        cellBackgroundView.addSubview(starImageView)
        cellBackgroundView.addSubview(contentsLabel)
        cellBackgroundView.addSubview(menteeNameLabel)
        cellBackgroundView.addSubview(menteeDevideDot)
        cellBackgroundView.addSubview(reviewDateLabel)
        cellBackgroundView.addSubview(viewMoreBtn)
        
        viewMoreBtn.titleEdgeInsets = UIEdgeInsets(top: 9, left: -32, bottom: 9, right: 0)
        viewMoreBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 34, bottom: 8, right: 8)
        
        profileBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(123)
        }
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalToSuperview()
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        mentorConfirmImg.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        mentorDevideDot.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.leading.equalTo(mentorDevideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
        starImageView.snp.makeConstraints {
            $0.top.equalTo(profileBtn.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(starImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(52)
        }
        menteeNameLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(21)
        }
        menteeDevideDot.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.top.equalTo(menteeNameLabel.snp.top)
            $0.leading.equalTo(menteeNameLabel.snp.trailing).offset(4)
        }
        reviewDateLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.leading.equalTo(menteeDevideDot.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().inset(21)
        }
        viewMoreBtn.snp.makeConstraints {
            $0.width.equalTo(58)
            $0.height.equalTo(32)
            $0.trailing.bottom.equalToSuperview().inset(12)
        }
    }

}
