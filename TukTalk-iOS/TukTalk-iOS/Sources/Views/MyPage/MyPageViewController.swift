//
//  MyPageViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit
import RxSwift

class MyPageViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    private let tableViewModel = MyPageTableViewModel()
    private let verification = "mentor" /// 서버 연동 후 변경 예정
    
    //MARK:- UI Components
    
    private let mainScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let mainContentView = UIView()
    
    private let settingBtn = UIButton().then {
        $0.setImage(UIImage(named: "settingBtn"), for: .normal)
    }
    
    private let profileImg = UIImageView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 35
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "tempProfileImg")
    }
    
    private let profileEditBtn = UIButton().then {
        $0.setImage(UIImage(named: "profileEditBtn"), for: .normal)
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "리즈님"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "안녕하세요."
        $0.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let notiBtn = UIButton().then {
        $0.setTitle("✉️ 멘토 인증을 해주셔야 활동하실 수 있습니다!", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.titleEdgeInsets = UIEdgeInsets(top: 12, left: -55, bottom: 12, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 14, left: 307, bottom: 14, right: 20)
        $0.setImage(UIImage(named: "arrowRightImg"), for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray5
        $0.layer.cornerRadius = 22
    }
    
    private let manageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    private let manageProfitBtn = UIButton().then {
        $0.setTitle("수익관리", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setImage(UIImage(named: "profitImg"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray4.cgColor
        $0.layer.cornerRadius = 8
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 64, left: -60, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 16, left: 69, bottom: 60, right: 16)
    }
    
    private let manageBookingBtn = UIButton().then {
        $0.setTitle("예약관리", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setImage(UIImage(named: "bookingImg"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray4.cgColor
        $0.layer.cornerRadius = 8
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 64, left: -60, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 16, left: 69, bottom: 60, right: 16)
    }
    
    private let manageMyServiceBtn = UIButton().then {
        $0.setTitle("내 서비스", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setImage(UIImage(named: "myServiceImg"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray4.cgColor
        $0.layer.cornerRadius = 8
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 64, left: -60, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 16, left: 69, bottom: 60, right: 16)
    }
    
    private let devideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    private let secondDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    private let thirdDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    private let myServiceLabel = UILabel().then {
        $0.text = "💬 나의 서비스"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let myServiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "arrowRightImg"), for: .normal)
    }
    
    private let myServiceView = UIView().then {
        $0.backgroundColor = UIColor.myPageColor
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let myServiceNilImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let myServiceNilLabel = UILabel().then {
        $0.text = "등록한 서비스가 없습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let myActivityTV = UITableView()
    private let etcServiceTV = UITableView()
    
    private let activityHeaderView = MyPageTableHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 56), user: "mentor", section: 0)
    private let serviceHeaderView = MyPageTableHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 56), user: "mentor", section: 1)
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setTableViewUI()
        binding()
        bindingTableView()
    }
    
    override func viewDidLayoutSubviews() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1270)
    }
    
    //MARK:- Function
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        mainContentView.addSubview(settingBtn)
        settingBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalToSuperview().offset(54)
            make.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(profileImg)
        profileImg.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.top.equalToSuperview().offset(88)
            make.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(profileEditBtn)
        profileEditBtn.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImg)
        }
        
        mainContentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(99)
            make.leading.equalTo(profileImg.snp.trailing).offset(20)
        }
        
        mainContentView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        mainContentView.addSubview(notiBtn)
        notiBtn.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(profileImg.snp.bottom).offset(20)
        }
        
        mainContentView.addSubview(manageStackView)
        manageStackView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(notiBtn.snp.bottom).offset(20)
        }
        manageStackView.addArrangedSubview(manageProfitBtn)
        manageStackView.addArrangedSubview(manageBookingBtn)
        manageStackView.addArrangedSubview(manageMyServiceBtn)
        
        mainContentView.addSubview(devideView)
        devideView.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(manageStackView.snp.bottom).offset(24)
        }
        
        mainContentView.addSubview(myServiceLabel)
        myServiceLabel.snp.makeConstraints { make in
            make.top.equalTo(devideView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(myServiceBtn)
        myServiceBtn.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(devideView.snp.bottom).offset(19)
            make.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(myServiceView)
        myServiceView.snp.makeConstraints { make in
            make.height.equalTo(135)
            make.top.equalTo(myServiceBtn.snp.bottom).offset(19)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        myServiceView.addSubview(myServiceNilImg)
        myServiceNilImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(43)
        }
        
        myServiceView.addSubview(myServiceNilLabel)
        myServiceNilLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(75)
        }
        
        mainContentView.addSubview(secondDevideView)
        secondDevideView.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(myServiceView.snp.bottom).offset(24)
        }
        
        mainContentView.addSubview(myActivityTV)
        myActivityTV.snp.makeConstraints { make in
            make.top.equalTo(secondDevideView.snp.bottom)
            make.height.equalTo(240)
            make.leading.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(thirdDevideView)
        thirdDevideView.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(myActivityTV.snp.bottom)
        }
        
        mainContentView.addSubview(etcServiceTV)
        etcServiceTV.snp.makeConstraints { make in
            make.top.equalTo(thirdDevideView.snp.bottom)
            make.height.equalTo(370)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setTableViewUI() {
        myActivityTV.separatorStyle = .none
        myActivityTV.isScrollEnabled = false
        myActivityTV.bounces = false
        etcServiceTV.separatorStyle = .none
        etcServiceTV.isScrollEnabled = false
        etcServiceTV.bounces = false
    }
    
    private func binding() {
        //TODO
    }
    
    private func bindingTableView() {
        myActivityTV.register(MyPageTableViewCell.self,
                              forCellReuseIdentifier: MyPageTableViewCell.identifier)
        myActivityTV.rx.setDelegate(self).disposed(by: disposeBag)
        myActivityTV.tableHeaderView = activityHeaderView
        tableViewModel.output.mentorActivityData
            .bind(to: myActivityTV.rx.items){( tv, row, item) -> UITableViewCell in
                if let cell = self.myActivityTV.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MyPageTableViewCell {
                    cell.setData(data: item)
                    cell.selectionStyle = .none
                    return cell
                }
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
        
        etcServiceTV.register(MyPageTableViewCell.self,
                              forCellReuseIdentifier: MyPageTableViewCell.identifier)
        etcServiceTV.rx.setDelegate(self).disposed(by: disposeBag)
        etcServiceTV.tableHeaderView = serviceHeaderView
        tableViewModel.output.mentorServiceData
            .bind(to: etcServiceTV.rx.items){( tv, row, item) -> UITableViewCell in
                if let cell = self.etcServiceTV.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MyPageTableViewCell {
                    cell.setData(data: item)
                    cell.selectionStyle = .none
                    return cell
                }
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController : UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}
