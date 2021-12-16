//
//  PortfolioViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import RxSwift
import RxCocoa
import Moya

class PortfolioViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = PortfolioPageViewModel()
    private let heightFrameValue = BehaviorRelay(value: Int(UIScreen.main.bounds.height))
    var heightFrame: Observable<Int> {
        return heightFrameValue.asObservable()
    }
    var mentorID: Int?
    var response: PortfolioPageResponse? = nil
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    let tableView = UITableView()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nilDataView()
        getMentorInform()
        setTableViewUI()
        bindingTableView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setTableViewUI() {
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
    private func bindingTableView() {
        tableView.register(PortfolioTVCell.self,
                           forCellReuseIdentifier: PortfolioTVCell.identifier)
        tableView.register(PortfolioPreviewTVCell.self,
                           forCellReuseIdentifier: PortfolioPreviewTVCell.identifier)
        tableView.register(PortfolioInformTVCell.self, forCellReuseIdentifier: PortfolioInformTVCell.identifier)
        tableView.register(PortfolioRecommendTVCell.self, forCellReuseIdentifier: PortfolioRecommendTVCell.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    func getMentorInform() {
        viewModel.getPortfolioPage(mentorID: mentorID ?? -1) { response in
            self.response = response
            self.setUI()
            self.tableView.reloadData()
        }
    }
    
    func nilDataView() {
        let emptyImg = UIImageView().then {
            $0.image = UIImage(named: "emptyIcon")
        }
        tableView.removeFromSuperview()
        view.addSubview(emptyImg)
        emptyImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}

extension PortfolioViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32)).then {
            $0.backgroundColor = .white
        }
        
        switch section {
        case 0:
            return headerView
        default:
            let headerLine = UIView()
            headerView.addSubview(headerLine)
            headerLine.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: 1)
            headerLine.backgroundColor = UIColor.GrayScale.gray3
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 32
        default:
            return 33
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTVCell.identifier, for: indexPath) as? PortfolioTVCell else { return UITableViewCell() }
            cell.setData(text: response?.reviewSearchResponseDescription ?? "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioPreviewTVCell.identifier, for: indexPath) as? PortfolioPreviewTVCell else { return UITableViewCell() }
            cell.previewCV.rx.itemSelected
                .bind { index in
                    let nextVC = PortfolioPreviewView()
                    nextVC.modalPresentationStyle = .overFullScreen
                    nextVC.imageView.image = cell.dataList[index.last!]
                    self.present(nextVC, animated: true, completion: nil)
                }
                .disposed(by: disposeBag)
            cell.setData(urlString: response?.imageFiles ?? [""])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioInformTVCell.identifier, for: indexPath) as? PortfolioInformTVCell else { return UITableViewCell() }
            cell.setData(projectCount: String(response?.projectCount ?? -1), totalPages: String(response?.totalPages ?? -1), startYear: String(response?.startYear ?? -1), endYear: String(response?.endYear ?? -1))
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioRecommendTVCell.identifier, for: indexPath) as? PortfolioRecommendTVCell else { return UITableViewCell() }
            let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
            let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
            heightFrameValue.accept(Int(rectOfCellInSuperview.origin.y))
            cell.setData(text: response?.recommendationTargetDescription ?? "")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 3:
            return 92
        default:
            return UITableView.automaticDimension
        }
        
    }
}
