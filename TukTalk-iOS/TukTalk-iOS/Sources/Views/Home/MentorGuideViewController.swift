//
//  MentorGuideViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/16.
//

import RxSwift

class MentorGuideViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let mainScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let mainContentView = UIView()
    
    private let topView = UIView(frame: .zero).then {
        $0.backgroundColor = .white
    }
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let firstSectionImg = UIImageView().then {
        $0.image = UIImage(named: "guideFirstImg")
    }
    
    private let registBtn = UIButton().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.setTitle("뚝딱 멘토 등록하기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }
    
    private let firstDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray2
    }
    
    private let secondSectionTitleLabel = UILabel().then {
        $0.text = "뚝딱멘토는 어떤 사람이 할 수 있나요? 🤔"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let secondSectionSubLabel = UILabel().then {
        $0.text = "현직자라면 누구나 뚝딱멘토가 바로 되실 수 있습니다!"
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let secondSectionImg = UIImageView().then {
        $0.image = UIImage(named: "guideSecondImg")
    }
    
    private let secondDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.normal
    }
    
    private let thirdSectionFirstTitleImg = UIImageView().then {
        $0.image = UIImage(named: "guideLightImg")
    }
    
    private let thirdSectionFirstTitleLabel = UILabel().then {
        $0.text = "만약 1~2년차 디자이너, 개발자이실 경우"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let thirdSectionFirstSubLabel = UILabel().then {
        $0.text = "오히려 더 좋습니다! 가장 최근에 취업에 성공하신 분들이기에 멘티분들이 더 필요한 정보를 가지고 계십니다. 멘토분의 포트폴리오로 당장 취업준비를 어떻게 해야할지, 신입 디자이너 혹은 신입 개발자의 포트폴리오 합격선은 어느정도일지, 대학생이나 인턴 프로젝트를 포트폴리오에 담아내실 때 어떻게 공고에 맞게 어필했는지 등을 멘티분들이 얻어가실 수 있을 것입니다."
        $0.textColor = UIColor.GrayScale.sub2
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 13)
    }
    
    private let thirdSectionSecondTitleImg = UIImageView().then {
        $0.image = UIImage(named: "guideCaseImg")
    }
    
    private let thirdSectionSecondTitleLabel = UILabel().then {
        $0.text = "5년이상 격력자, 탑 기업의 디자이너, 개발자이실경우"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let thirdSectionSecondSubLabel = UILabel().then {
        $0.text = "여기에 해당이 되시는 멘토분들은 이미 남들이 인정할만한 경력을 가지고 계시기 때문에 신입은 물론 이직을 원하시는 분들에게도 도움이 되실 겁니다. 그리고 멘토링 부분에 있어서 멘토분이 같이 일하고 싶은 사람, 사용하는 기술스택, 채용에 있어서 중요하게 여기는 점들에 대해 멘토링해주신다면 멘티분이 많은 도움을 받으실 겁니다."
        $0.textColor = UIColor.GrayScale.sub2
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 13)
    }
    
    private let fourthSectionLabel = UILabel().then {
        $0.text = "자격조건"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let fourthSectionDevideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.normal
    }
    
    private let fourthSectionImg = UIImageView().then {
        $0.image = UIImage(named: "guideThirdImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let fourthSectionTitleLabel = UILabel().then {
        $0.text = "그럼 무엇을 제공하면 되는 건가요?"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let fourthSectionSubLabel = UILabel().then {
        $0.text = "여러분이 취업할 때 사용했던 합격 자소서, 이력서\n포트폴리오만 있으면 뚝딱멘토가 될 수 있습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 13)
    }
    
    private let fourthSectionBackgroundView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray5
        $0.layer.cornerRadius = 12
    }
    
    private let fourthSectionBackgroundViewLabel = UILabel().then {
        $0.text = "· 어떤 기업, 무슨 직군에 합격한 파일인지\n· 제작 시기가 언제인지\n· 몇 페이지인지\n· 어떤 멘티분들에게 추천드리는지\n· 자소서/이력서/포트폴리오에 어떤 질문이 있는지, 어떤 내용이 담겨있는지 간략한 설명\n· 미리보기 이미지 업로드"
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 13)
    }
    
    private let finalSectionDevideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.normal
    }
    
    private let finalSectionImg = UIImageView().then {
        $0.image = UIImage(named: "guideFourthImg")
    }
    
    private let finalSectionTitleFirstLabel = UILabel().then {
        $0.text = "제 소중한 콘텐츠의 저작권 보호가"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 14)
    }
    
    private let finalSectionTitleSecondLabel = UILabel().then {
        $0.text = "제대로 이루어질까 걱정돼요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let finalSectionSubLabel = UILabel().then {
        $0.text = "· 뚝딱은 공유자분들의 소중한 저작권을 보호하기 위해 최선을 다합니다.\n· 공유해주신 파일 앞장에 저작권에 대한 경고페이지가 들어갈 예정입니다.\n· 파일의 모든 페이지마다 뚝딱 로고의 워터마크를 새김으로써 불법배포를 사전에 방지합니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 13)
    }
    
    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setScrollView() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1700)
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .white
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints {
            $0.width.height.equalTo(mainScrollView.contentSize)
            $0.edges.equalTo(mainScrollView.contentSize)
        }
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        topView.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        mainContentView.addSubview(firstSectionImg)
        firstSectionImg.snp.makeConstraints {
            $0.height.equalTo(130)
            $0.width.equalTo(223)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(registBtn)
        registBtn.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(160)
            $0.top.equalTo(firstSectionImg.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(firstDevideView)
        firstDevideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(registBtn.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(secondSectionTitleLabel)
        secondSectionTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(firstDevideView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(secondSectionSubLabel)
        secondSectionSubLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(secondSectionTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(secondSectionImg)
        secondSectionImg.snp.makeConstraints {
            $0.width.equalTo(219)
            $0.height.equalTo(151)
            $0.top.equalTo(secondSectionSubLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(secondDevideView)
        secondDevideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(secondSectionImg.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(thirdSectionFirstTitleImg)
        thirdSectionFirstTitleImg.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalTo(secondDevideView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(thirdSectionFirstTitleLabel)
        thirdSectionFirstTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(secondDevideView.snp.bottom).offset(22)
            $0.leading.equalTo(thirdSectionFirstTitleImg.snp.trailing).offset(8)
        }
        
        mainContentView.addSubview(thirdSectionFirstSubLabel)
        thirdSectionFirstSubLabel.snp.makeConstraints {
            $0.top.equalTo(thirdSectionFirstTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(thirdSectionSecondTitleImg)
        thirdSectionSecondTitleImg.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalTo(thirdSectionFirstSubLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }

        mainContentView.addSubview(thirdSectionSecondTitleLabel)
        thirdSectionSecondTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(thirdSectionFirstSubLabel.snp.bottom).offset(36)
            $0.leading.equalTo(thirdSectionSecondTitleImg.snp.trailing).offset(8)
        }

        mainContentView.addSubview(thirdSectionSecondSubLabel)
        thirdSectionSecondSubLabel.snp.makeConstraints {
            $0.top.equalTo(thirdSectionSecondTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(fourthSectionLabel)
        fourthSectionLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(thirdSectionSecondSubLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(fourthSectionDevideView)
        fourthSectionDevideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(fourthSectionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(fourthSectionImg)
        fourthSectionImg.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(fourthSectionDevideView.snp.bottom).offset(8)
        }
        
        mainContentView.addSubview(fourthSectionTitleLabel)
        fourthSectionTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(fourthSectionImg.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(fourthSectionSubLabel)
        fourthSectionSubLabel.snp.makeConstraints {
            $0.top.equalTo(fourthSectionTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(fourthSectionBackgroundView)
        fourthSectionBackgroundView.snp.makeConstraints {
            $0.height.equalTo(158)
            $0.top.equalTo(fourthSectionSubLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        fourthSectionBackgroundView.addSubview(fourthSectionBackgroundViewLabel)
        fourthSectionBackgroundViewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        mainContentView.addSubview(finalSectionDevideView)
        finalSectionDevideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(fourthSectionBackgroundView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        mainContentView.addSubview(finalSectionImg)
        finalSectionImg.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(finalSectionDevideView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(finalSectionTitleFirstLabel)
        finalSectionTitleFirstLabel.snp.makeConstraints {
            $0.top.equalTo(finalSectionImg.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(finalSectionTitleSecondLabel)
        finalSectionTitleSecondLabel.snp.makeConstraints {
            $0.top.equalTo(finalSectionTitleFirstLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        mainContentView.addSubview(finalSectionSubLabel)
        finalSectionSubLabel.snp.makeConstraints {
            $0.top.equalTo(finalSectionTitleSecondLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        registBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(CertifyMentorFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
