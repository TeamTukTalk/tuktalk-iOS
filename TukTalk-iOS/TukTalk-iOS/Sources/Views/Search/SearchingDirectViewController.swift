//
//  SearchingDirectViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/27.
//

import RxSwift

class SearchingDirectViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var mentorCVModel = MentorListCollectionViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    let searchTextBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.contentHorizontalAlignment = .left
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
    }
    
    private let searchTextUnderline = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray1
    }
    
    private let clearBtn = UIButton().then {
        $0.setImage(UIImage(named: "clearImg"), for: .normal)
    }
    
    private let mentorListCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let devideLineView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray3
        $0.isHidden = true
    }
    
    //MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextBtn)
        searchTextBtn.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchTextBtn.addSubview(clearBtn)
        clearBtn.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        view.addSubview(searchTextUnderline)
        searchTextUnderline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(searchTextBtn.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(mentorListCV)
        mentorListCV.snp.makeConstraints {
            $0.top.equalTo(searchTextUnderline.snp.bottom).offset(32)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        mentorListCV.addSubview(devideLineView)
        devideLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalToSuperview()
            $0.leading.equalTo(mentorListCV.snp.leading)
            $0.trailing.equalTo(mentorListCV.snp.trailing)
        }
    }
    
    private func setCollectionViewUI() {
        let mentorListCVLayout = UICollectionViewFlowLayout()
        mentorListCVLayout.minimumLineSpacing = 8
        mentorListCVLayout.minimumInteritemSpacing = .zero
        mentorListCVLayout.scrollDirection = .vertical
        mentorListCVLayout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        mentorListCV.setCollectionViewLayout(mentorListCVLayout, animated: false)
        mentorListCV.backgroundColor = .white
        mentorListCV.showsVerticalScrollIndicator = false
        mentorListCV.register(MentorListCollectionViewCell.self, forCellWithReuseIdentifier: "MentorListCollectionViewCell")
    }
    
    private func binding() {
        searchTextBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(SearchDirectViewController(), animated: false)
            }
            .disposed(by: disposeBag)
        
        clearBtn.rx.tap
            .bind { _ in
                self.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        mentorListCV.rx.modelSelected(MentorListDataModel.self)
            .bind { _ in
                self.navigationController?.pushViewController(MentorInformationViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    private func bindingCollectionView() {
        mentorListCV.rx.setDelegate(self).disposed(by: disposeBag)
        
//        mentorCVModel.output.searchingMentorListData
//            .bind(to: mentorListCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
//                if let cell = self.mentorListCV.dequeueReusableCell(withReuseIdentifier: "MentorListCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? MentorListCollectionViewCell {
//                    
//                    cell.setData(mentor: item)
//                    return cell
//                }
//                return UICollectionViewCell()
//            }
//            .disposed(by: disposeBag)
    }
}

extension SearchingDirectViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mentorListCV {
            if scrollView.contentOffset.y > 0 {
                devideLineView.snp.updateConstraints {
                    $0.top.equalTo(scrollView.contentOffset.y)
                }
                devideLineView.isHidden = false
            } else {
                devideLineView.snp.updateConstraints {
                    $0.top.equalTo(0)
                }
                devideLineView.isHidden = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 135)
    }
    
}
