//
//  MypageReviewManageView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift

class ReviewManageViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    var portfolioHistoryData: HistoryPortfolioResponse?
    
    private lazy var writeReviewVC = WriteReviewViewController()
    private lazy var writtenReviewVC = WrittenReviewViewController()
    
    private var currentPage: Int = 0 {
        didSet {
            pageBind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    private lazy var dataViewControllers: [UIViewController] = [writeReviewVC, writtenReviewVC]
    
    //MARK:- UI Components
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private let topView = UIView()
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "리뷰관리"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let pageDevideView = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setPageView()
        setCollectionViewUI()
        binding()
        bindingCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBar()
        currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: Function
    
    private func setBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview()
        }
        
        topView.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        
        topView.addSubview(backBtnLabel)
        backBtnLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backBtn)
            $0.leading.equalTo(backBtn.snp.trailing).offset(4)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(38)
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(pageDevideView)
        pageDevideView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalToSuperview().offset(124)
            $0.leading.trailing.equalToSuperview()
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
        writeReviewVC.response = portfolioHistoryData
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setCollectionViewUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        collectionView.isScrollEnabled = false
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
    }
    
    private func binding() {
        collectionView.rx.itemSelected
            .bind(onNext: {index in
                if self.currentPage != index[1] {
                    self.startLoading()
                    self.currentPage = index[1]
                }
            })
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.of(["리뷰작성", "작성한 리뷰"])
            .bind(to: collectionView.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? PageCollectionViewCell {
                    
                    cell.configure(title: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func pageBind(oldValue: Int, newValue: Int) {
        
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([dataViewControllers[currentPage]], direction: direction, animated: true, completion: { _ in
            self.endLoading()
        })
        
        collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ReviewManageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 38)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished { self.endLoading() }
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataViewControllers.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}

extension ReviewManageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex == 1 {
            startLoading()
        }
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == 1 {
            startLoading()
        }
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
