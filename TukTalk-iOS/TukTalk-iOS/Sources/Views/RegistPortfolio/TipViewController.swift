//
//  TipView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import UIKit

final class TipViewController: UIViewController {
    
    //MARK:- Properties
    
    private let contentView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 8
    }
    
    private let tipImageView = UIImageView().then {
        $0.image = UIImage(named: "tipImg")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "포트폴리오 소개 TIP"
        $0.textColor = UIColor.GrayScale.normal
        $0.font = UIFont.TTFont(type: .SDMed, size: 16)
    }
    
    private let subLabel = UILabel().then {
        $0.text = "작성팁을 참고해서 내 서비스를 설명해보세요!"
        $0.textColor = UIColor.GrayScale.sub2
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
    }
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.addTarget(self, action: #selector(dismissAlertController), for: .touchUpInside)
    }
    
    private let contentTextView = UITextView()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
        setUI()
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(162)
        }
        
        contentView.addSubview(tipImageView)
        tipImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(tipImageView.snp.trailing).offset(12)
        }
        
        contentView.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(tipImageView.snp.trailing).offset(12)
        }
        
        contentView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setTextView() {
        let title = "📍 뚝딱 멘티가 상세 소개글을 읽고 선택에 참고할 수 있도록 정확한 정보, 특징, 구체적인 설명, 뚝딱멘티에게 도움이 될 정보, 사용 툴이나 기술, 예상 Q&A를 잘 녹여주세요.\n\n"
        let example = "EX)\n\n"
        let exampleText = "제 포트폴리오는 A회사에 프론트엔드 웹 신입개발자로 합격한 포트폴리오입니다.\n저는 주로 javascript, typescript, react등의 기술스택을 중점적으로 다루고 포트폴리오에 녹여냈습니다.\n- 포트폴리오에 신경 쓴 부분\n저는 개인적으로 프론트엔드 개발자 직무에 적합하다는 것을 보여주기 위해서 포트폴리오를 한눈에 보기 쉽고, 군더더기 없이 깔끔하게 만드는 부분을 중요하게 생각하며 제 포트폴리오를 만들었습니다.\n그리고 프로젝트 하나하나마다 프로젝트를 진행할때 어떤 부분을 중점적으로 다뤘고, 어떤 새로운 기술을 도입해봤고처럼 프로젝트를 진행하는데에 느꼈던 주관적인 느낀점, 극복경험등도 간략하게 작성했습니다."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20/6
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.TTFont(type: .SDMed, size: 14)])
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, title.count))
        attributedText.append(NSAttributedString(string: example, attributes: [NSAttributedString.Key.foregroundColor: UIColor.Primary.primary, NSAttributedString.Key.font: UIFont.TTFont(type: .SFMed, size: 12)]))
        attributedText.append(NSAttributedString(string: exampleText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.GrayScale.sub1, NSAttributedString.Key.font: UIFont.TTFont(type: .SDReg, size: 14)]))
        
        contentTextView.attributedText = attributedText
    }
}
