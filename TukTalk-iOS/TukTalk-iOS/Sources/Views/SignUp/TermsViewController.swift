//
//  TermsViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import RxSwift

class TermsViewController: UIViewController {
    
    //MARK:- Properties
    
    private var tableViewModel = TemrsTableViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 12
        $0.frame.size.width = 12
    }
    
    private let tableView = UITableView()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 736 {
                $0.top.equalToSuperview().offset(39)
            } else {
                $0.top.equalToSuperview().offset(59)
            }
            $0.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TermsTVTitleCell.self,
                           forCellReuseIdentifier: TermsTVTitleCell.identifier)
        tableView.register(TermsTVContentCell.self,
                           forCellReuseIdentifier: TermsTVContentCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension TermsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.titleDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewModel.open[section] {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TermsTVTitleCell.identifier, for: indexPath) as? TermsTVTitleCell else { return UITableViewCell()}
            cell.setData(text: tableViewModel.titleDataList[indexPath.section], open: tableViewModel.open[indexPath.section])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TermsTVContentCell.identifier, for: indexPath) as? TermsTVContentCell else { return UITableViewCell()}
            cell.setData(string: tableViewModel.getAttributedText(index: indexPath.section))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 56
        } else {
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TermsTVTitleCell else { return }
        guard let index = tableView.indexPath(for: cell) else { return }
        if index.row == indexPath.row {
            if index.row == 0 {
                if !tableViewModel.open[indexPath.section] {
                    let section = IndexSet.init(integer: indexPath.section)
                    tableViewModel.open[indexPath.section] = true
                    tableView.reloadSections(section, with: .fade)
                } else {
                    let section = IndexSet.init(integer: indexPath.section)
                    tableViewModel.open[indexPath.section] = false
                    tableView.reloadSections(section, with: .fade)
                }
            }
        }
    }
}
