//
//  InformationViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import RxSwift
import RxCocoa

class InformationViewController: UIViewController {
    
    //MARK:- Properties
    
    private let heightFrameValue = BehaviorRelay(value: Int(UIScreen.main.bounds.height))
    var heightFrame: Observable<Int> {
        return heightFrameValue.asObservable()
    }
    var mentorID: Int?
    var response: MentorPageResponse?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    let tableView = UITableView()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
        tableView.register(IntroduceTableViewCell.self,
                           forCellReuseIdentifier: IntroduceTableViewCell.identifier)
        tableView.register(CompanyTableViewCell.self,
                           forCellReuseIdentifier: CompanyTableViewCell.identifier)
        tableView.register(CareerTableViewCell.self, forCellReuseIdentifier: CareerTableViewCell.identifier)
        tableView.register(SpecialtyTableViewCell.self, forCellReuseIdentifier: SpecialtyTableViewCell.identifier)
        tableView.register(TagTableViewCell.self, forCellReuseIdentifier: TagTableViewCell.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
        
    }
}

extension InformationViewController : UITableViewDelegate, UITableViewDataSource {
    
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntroduceTableViewCell.identifier, for: indexPath) as? IntroduceTableViewCell else { return UITableViewCell() }
            cell.setData(text: response?.detailedIntroduction ?? "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier, for: indexPath) as? CompanyTableViewCell else { return UITableViewCell() }
            cell.setData(company: response?.companyName ?? "", specialty: response?.specialty ?? "", position: response?.position ?? "", year: String((response?.career.years) ?? 0), month: String((response?.career.months) ?? 0))
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CareerTableViewCell.identifier, for: indexPath) as? CareerTableViewCell else { return UITableViewCell() }
            cell.setData(text: response?.careerDescription ?? "")
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecialtyTableViewCell.identifier, for: indexPath) as? SpecialtyTableViewCell else { return UITableViewCell() }
            cell.setData(data: response?.subSpecialties ?? [SubSpecialty]())
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.identifier, for: indexPath) as? TagTableViewCell else { return UITableViewCell() }
            let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
            let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
            heightFrameValue.accept(Int(rectOfCellInSuperview.origin.y))
            cell.setData(data: response?.hashTags ?? [HashTag]())
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 4:
            return 92
        default:
            return UITableView.automaticDimension
        }
        
    }
}
