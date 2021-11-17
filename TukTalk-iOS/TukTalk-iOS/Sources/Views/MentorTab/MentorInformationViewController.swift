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

        currentPage = 0
    }

    //MARK: Function

    private func setUI() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(38)
            $0.top.equalToSuperview().offset(453)
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
