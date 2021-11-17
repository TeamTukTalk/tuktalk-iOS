//
//  MentorInformationViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import RxSwift
import RxCocoa

class MentorInformationViewController: UIViewController {

    //MARK:- Properties

    private lazy var viewModel = MentorInformationViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource: [PageCollectionViewDataModel] = []

    private lazy var informationVC = UIViewController().then {
        $0.view.backgroundColor = .blue
    }
    private lazy var portfolioVC = UIViewController().then {
        $0.view.backgroundColor = .red
    }
    private lazy var consultingVC = UIViewController().then {
        $0.view.backgroundColor = .yellow
    }
    private lazy var reviewVC = UIViewController().then {
        $0.view.backgroundColor = .green
    }

    var currentPage: Int = 0 {
        didSet {
            pageBind(oldValue: oldValue, newValue: currentPage)
        }
    }

    private lazy var dataViewControllers: [UIViewController] = [informationVC, portfolioVC, consultingVC, reviewVC]

    //MARK:- UI Components

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let heartBtn = UIButton().then {
        $0.setImage(UIImage(named: "heartImg"), for: .normal)
    }
    
    private let profileView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.cornerRadius = 16
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
    }
    
    private let profileImage = UIImageView().then {
        $0.image = UIImage(named: "tempProfileImg")
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    private let profileImageView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 35
    }
    
    private let profileNameLabel = UILabel().then {
        $0.text = "애니"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let confirmImage = UIImageView().then {
        $0.image = UIImage(named: "mentorConfirmImg")
    }
    
    private var companyLabel = UILabel().then {
        $0.text = "네이버"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let devideDot = UILabel().then {
        $0.text = "·"
        $0.textAlignment = .center
        $0.textColor = UIColor.GrayScale.gray1
    }
    private let jobLabel = UILabel().then {
        $0.text = "UXUI 디자인"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let devideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray3
    }
    
    private let introduceLabel = UILabel().then {
        $0.text = "네이버에서 UXUI 디자이너로 재직중인 애니입니다 :)\n한줄소개는 두줄까지 나오고 중간 맞춤됩니다."
        $0.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.GrayScale.sub2
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 12)
        $0.textAlignment = .center
    }
    
    private let consultingBtn = UIButton().then {
        $0.setTitle("1:1 멘토링 신청", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.backgroundColor = UIColor.Primary.primary
        $0.layer.cornerRadius = 22
    }
    
    private let openPortfolioBtn = UIButton().then {
        $0.setTitle("포트폴리오 유로 열람", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
    }

    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationController?.navigationBar.isHidden = true
        setPageView()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        currentPage = 0
    }

    //MARK: Function

    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(heartBtn)
        heartBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().inset(16)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(38)
            $0.top.equalToSuperview().offset(453)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.height.equalTo(337)
            $0.top.equalToSuperview().offset(92)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        profileView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerX.centerY.equalToSuperview()
        }
        
        profileView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(147.5)
        }
        
        profileView.addSubview(confirmImage)
        confirmImage.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(profileNameLabel)
            $0.leading.equalTo(profileNameLabel.snp.trailing)
        }
        
        profileView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(108)
        }
        
        profileView.addSubview(devideDot)
        devideDot.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.top.equalTo(companyLabel.snp.top)
            $0.leading.equalTo(companyLabel.snp.trailing).offset(6)
        }
        
        profileView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.equalTo(devideDot.snp.trailing).offset(6)
            $0.top.equalTo(companyLabel)
        }
        
        profileView.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(companyLabel.snp.bottom).offset(12)
        }
        
        profileView.addSubview(introduceLabel)
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(devideView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileView.addSubview(consultingBtn)
        consultingBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(devideView.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileView.addSubview(openPortfolioBtn)
        openPortfolioBtn.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(consultingBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
    }

    private func setPageView() {
        pageViewController.dataSource = self
        pageViewController.delegate = self

        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    private func setCollectionViewUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = (UIScreen.main.bounds.width - 329) / 3
        flowLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        collectionView.isScrollEnabled = false
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
    }

    private func binding() {
        collectionView.rx.itemSelected
            .bind(onNext: {index in
                self.currentPage = index[1]
            })
            .disposed(by: disposeBag)
    }

    private func bindingCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        viewModel.output.pageData
            .bind(to: collectionView.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? PageCollectionViewCell {

                    cell.configure(title: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }

    private func pageBind(oldValue: Int, newValue: Int) {

        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([dataViewControllers[currentPage]], direction: direction, animated: true, completion: nil)

        collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension MentorInformationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var items: [PageCollectionViewDataModel] = []

        viewModel.output.pageData
            .subscribe(onNext: {data in
                items = data
            })
            .disposed(by: disposeBag)

        return PageCollectionViewCell.fittingSize(availableHeight: 38, title: items[indexPath.row].title)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataViewControllers.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}

extension MentorInformationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
