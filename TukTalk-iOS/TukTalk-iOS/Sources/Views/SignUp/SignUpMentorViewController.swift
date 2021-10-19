//
//  SignUpMentoViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/16.
//

import SnapKit
import Then

class SignUpMentorViewController: UIViewController {
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 12
        $0.frame.size.width = 12
        $0.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
    }
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.frame.size.height = 13
        $0.frame.size.width = 13
        $0.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "뚝딱에서 어떤 서비스를\n이용하고 싶으세요?"
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.top)
            make.trailing.equalToSuperview().inset(19)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(122)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeBtnAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
