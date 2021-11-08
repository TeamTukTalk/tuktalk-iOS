//
//  BannerCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/08.
//

import RxSwift

struct BannerCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var bannerListData: Observable<[BannerDataModel]>
    }
    
    // 추후 변경 예정
    var bannerList: [BannerDataModel] = [
        BannerDataModel(image: UIImage(named: "firstBanner") ?? UIImage()),
        BannerDataModel(image: UIImage(named: "firstBanner") ?? UIImage())
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let bannerListData$ = Observable<[BannerDataModel]>.just(bannerList)
        
        self.input = Input()
        self.output = Output(bannerListData: bannerListData$)
    }
}
