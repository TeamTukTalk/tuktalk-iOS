//
//  MenteeReviewViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/18.
//

import RxSwift

class MenteeReviewViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = ReviewCollectionViewModel()
    private var dataCount = 0
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "뚝딱멘티들의 실시간 후기 📋"
        $0.font = UIFont.TTFont(type: .SDBold, size: 17)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let tableView = UITableView()
    
    private let devideLineView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableViewUI()
        binding()
        bindingTableView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(grayBackgroundView)
        grayBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        grayBackgroundView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.addSubview(devideLineView)
        devideLineView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalToSuperview()
            $0.leading.equalTo(tableView.snp.leading)
            $0.trailing.equalTo(tableView.snp.trailing)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func setTableViewUI() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.GrayScale.gray5
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingTableView() {
        tableView.register(MenteeReviewTableViewCell.self,
                           forCellReuseIdentifier: MenteeReviewTableViewCell.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.reviewListData
            .bind(onNext: { data in
                self.dataCount = data.count
            })
            .disposed(by: disposeBag)
        
        viewModel.output.reviewListData
            .bind(to: tableView.rx.items){( tv, row, item) -> UITableViewCell in
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: MenteeReviewTableViewCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MenteeReviewTableViewCell {
                    cell.setData(model: item)
                    if row == 0 {
                        cell.cellBackgroundView.snp.updateConstraints {
                            $0.top.equalToSuperview().offset(16)
                        }
                    } else if row == self.dataCount - 1 {
                        cell.cellBackgroundView.snp.updateConstraints {
                            $0.bottom.equalToSuperview().inset(-16)
                        }
                    }
                    cell.profileBtn.addTarget(self, action: #selector(self.profileBtnAction), for: .touchUpInside)
                    cell.viewMoreBtn.rx.tap
                        .take(1)
                        .bind { _ in
                            cell.viewMoreBtnAction()
                        }
                        .disposed(by: self.disposeBag)
                    cell.viewMoreBtn.addTarget(self, action: #selector(self.tableViewReloadData), for: .touchUpInside)
                    return cell
                }
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    @objc func profileBtnAction() {
        self.navigationController?.pushViewController(MentorInformationViewController(), animated: true)
    }
    
    @objc func tableViewReloadData() {
        self.tableView.reloadData()
    }
    
}

extension MenteeReviewViewController : UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MenteeReviewViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
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
}
