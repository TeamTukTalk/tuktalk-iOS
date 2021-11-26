//
//  SpecialityViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/13.
//

import RxSwift
import RxCocoa

final class FieldViewController: UIViewController {
    
    //MARK:- Properties
    
    lazy var viewModel = FieldViewModel()
    private let disposeBag = DisposeBag()
    let outputFieldData = BehaviorSubject(value: "")
    private let selectedAllValue = BehaviorRelay(value: false)
    var selectedAll: Observable<Bool> {
        return selectedAllValue.asObservable()
    }
    
    //MARK:- UI Components
    
    private let fieldTableView = UITableView().then {
        $0.layer.cornerRadius = 9
    }

    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewUI()
        bindingTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bindingNextBtn()
    }

    //MARK:- Functions

    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        view.addSubview(fieldTableView)
        viewModel.output.fieldData
            .bind(onNext: { data in
                var height = data.count * 46
                if data.count > 5 {
                    height = 5 * 46
                    self.fieldTableView.flashScrollIndicators()
                }
                self.fieldTableView.snp.makeConstraints {
                    $0.height.equalTo(height + 8)
                    $0.centerY.equalToSuperview()
                    $0.leading.trailing.equalToSuperview().inset(21)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableViewUI() {
        fieldTableView.separatorStyle = .none
        fieldTableView.bounces = false
        fieldTableView.backgroundColor = .white
        fieldTableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    private func bindingTableView() {
        fieldTableView.register(FieldTableViewCell.self,
                              forCellReuseIdentifier: FieldTableViewCell.identifier)
        fieldTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.fieldData
            .bind(to: fieldTableView.rx.items){( tv, row, item) -> UITableViewCell in
                if let cell = self.fieldTableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: IndexPath.init(row: row, section: 0)) as? FieldTableViewCell {
                    cell.setData(data: item)
                    cell.selectionStyle = .none
                    return cell
                }
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
        
        fieldTableView.rx.modelSelected(FieldTableViewDataModel.self)
            .subscribe(onNext: { model in
                self.outputFieldData.onNext(model.title)
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindingNextBtn() {
        self.selectedAllValue.accept(true)
    }
    
}

extension FieldViewController : UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}
