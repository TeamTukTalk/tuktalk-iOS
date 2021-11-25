//
//  WhichFieldInViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/21.
//

import RxSwift

class SignUpSecondViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = SignUpSecondViewModel()
    private let user = UserSignUp.shared
    private var selectedNum = 0
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 12
        $0.frame.size.width = 12
    }
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.frame.size.height = 20
        $0.frame.size.width = 20
    }
    
    let titleLabel = UILabel().then {
        $0.text = "어떤 분야에\n관심 있으신가요?👀"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.layer.cornerRadius = 26
        $0.isEnabled = false
    }
    
    private let designCategoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let itDevCategoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height == 667 {
                $0.top.equalToSuperview().offset(39)
            } else {
                $0.top.equalToSuperview().offset(59)
            }
            $0.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height == 667 {
                $0.top.equalToSuperview().offset(36)
            } else {
                $0.top.equalToSuperview().offset(56)
            }
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(designCategoryCV)
        designCategoryCV.snp.makeConstraints {
            if UIScreen.main.bounds.width == 428 {
                $0.height.equalTo(84)
            } else {
                $0.height.equalTo(132)
            }
            $0.top.equalTo(titleLabel.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(itDevCategoryCV)
        itDevCategoryCV.snp.makeConstraints {
            $0.height.equalTo(84)
            $0.top.equalTo(designCategoryCV.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(42)
        }
    }
    
    private func setCollectionViewUI() {
        let designFlowLayout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        designFlowLayout.minimumLineSpacing = 12
        designFlowLayout.minimumInteritemSpacing = 8
        designFlowLayout.scrollDirection = .vertical
        designCategoryCV.setCollectionViewLayout(designFlowLayout, animated: false)
        designCategoryCV.backgroundColor = .white
        designCategoryCV.isScrollEnabled = false
        designCategoryCV.allowsMultipleSelection = true
        
        let itDevFlowLayout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        itDevFlowLayout.minimumLineSpacing = 12
        itDevFlowLayout.minimumInteritemSpacing = 8
        itDevFlowLayout.scrollDirection = .vertical
        itDevCategoryCV.setCollectionViewLayout(itDevFlowLayout, animated: false)
        itDevCategoryCV.backgroundColor = .white
        itDevCategoryCV.isScrollEnabled = false
        itDevCategoryCV.allowsMultipleSelection = true
    }
    
    private func binding() {
        
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind { _ in
                let popUpViewController = PopUpViewController()
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            }
            .disposed(by: disposeBag)
        
        designCategoryCV.rx.modelSelected(FieldCategoryDataModel.self)
            .bind(onNext: { model in
                self.user.field.append(model.category)
                self.selectedNum += 1
                self.viewModel.input.selectedNum.onNext(self.selectedNum)
            })
            .disposed(by: disposeBag)
        
        designCategoryCV.rx.modelDeselected(FieldCategoryDataModel.self)
            .bind(onNext: { model in
                if let index = self.user.field.firstIndex(of: model.category) {
                    self.user.field.remove(at: index)
                }
                self.selectedNum -= 1
                self.viewModel.input.selectedNum.onNext(self.selectedNum)
            })
            .disposed(by: disposeBag)
        
        itDevCategoryCV.rx.modelSelected(FieldCategoryDataModel.self)
            .bind(onNext: { model in
                self.user.field.append(model.category)
                self.selectedNum += 1
                self.viewModel.input.selectedNum.onNext(self.selectedNum)
            })
            .disposed(by: disposeBag)
        
        itDevCategoryCV.rx.modelDeselected(FieldCategoryDataModel.self)
            .bind(onNext: { model in
                if let index = self.user.field.firstIndex(of: model.category) {
                    self.user.field.remove(at: index)
                }
                self.selectedNum -= 1
                self.viewModel.input.selectedNum.onNext(self.selectedNum)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.nextBtnEnable
            .bind(onNext: { valid in
                self.nextBtn.isEnabled = valid
                self.nextBtn.backgroundColor = valid ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.nextBtn.setTitleColor(valid ? .white : UIColor.GrayScale.sub4, for: .normal)
                
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(SignUpThirdViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        designCategoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        itDevCategoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        designCategoryCV.register(FirstFieldCategoryCVCell.self, forCellWithReuseIdentifier: "FirstFieldCategoryCVCell")
        itDevCategoryCV.register(SecondFieldCategoryCVCell.self, forCellWithReuseIdentifier: "SecondFieldCategoryCVCell")
        
        viewModel.output.designData
            .bind(to: designCategoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.designCategoryCV.dequeueReusableCell(withReuseIdentifier: "FirstFieldCategoryCVCell", for: IndexPath.init(row: row, section: 0)) as? FirstFieldCategoryCVCell {
                    cell.configure(title: item.category)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.itDevData
            .bind(to: itDevCategoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.itDevCategoryCV.dequeueReusableCell(withReuseIdentifier: "SecondFieldCategoryCVCell", for: IndexPath.init(row: row, section: 0)) as? SecondFieldCategoryCVCell {
                    cell.configure(title: item.category)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension SignUpSecondViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [FieldCategoryDataModel] = []
        
        switch collectionView {
        case designCategoryCV:
            viewModel.output.designData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
            
            return FirstFieldCategoryCVCell.fittingSize(availableHeight: 36, title: items[indexPath.row].category)
        default:
            viewModel.output.itDevData
                .subscribe(onNext: {data in
                    items = data
                })
                .disposed(by: disposeBag)
            
            return SecondFieldCategoryCVCell.fittingSize(availableHeight: 36, title: items[indexPath.row].category)
        }
    }
}
