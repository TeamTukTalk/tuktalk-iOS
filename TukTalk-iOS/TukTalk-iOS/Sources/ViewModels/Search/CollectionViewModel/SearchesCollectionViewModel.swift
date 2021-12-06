//
//  RecentSearchViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import RxSwift

final class SearchesCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var recentSearchesData: Observable<[SearchesDataModel]>
        var designCategoryData: Observable<[SearchesDataModel]>
        var itDevCategoryData: Observable<[SearchesDataModel]>
        var jobCategoryData: Observable<[SearchesDataModel]>
    }
    
    var recentSearchesList: [SearchesDataModel] = [
        // 추후 서버연동 후 변경 예정
        SearchesDataModel(title: "로고/브랜딩"),
        SearchesDataModel(title: "스타트업"),
        SearchesDataModel(title: "디자이너"),
        SearchesDataModel(title: "대기업"),
        SearchesDataModel(title: "카카오"),
        SearchesDataModel(title: "개발")
    ]
    
    var designCategoryList: [SearchesDataModel] = [
        SearchesDataModel(title: "UXUI 디자인"),
        SearchesDataModel(title: "웹 디자인"),
        SearchesDataModel(title: "브랜드 디자인"),
        SearchesDataModel(title: "그래픽 디자인"),
        SearchesDataModel(title: "산업/제품 디자인")
    ]
    
    var itDevCategoryList: [SearchesDataModel] = [
        SearchesDataModel(title: "앱"),
        SearchesDataModel(title: "웹"),
        SearchesDataModel(title: "IT/개발직군"),
        SearchesDataModel(title: "서버"),
        SearchesDataModel(title: "AI/머신러닝"),
        SearchesDataModel(title: "데이터"),
        SearchesDataModel(title: "게임"),
        SearchesDataModel(title: "기타")
    ]
    
    var jobCategoryList: [SearchesDataModel] = [
        SearchesDataModel(title: "디자인"),
        SearchesDataModel(title: "IT/개발")
    ]
    
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let recentSearchesData$ = Observable<[SearchesDataModel]>.just(recentSearchesList)
        let designCategoryData$ = Observable<[SearchesDataModel]>.just(designCategoryList)
        let itDevCategoryData$ = Observable<[SearchesDataModel]>.just(itDevCategoryList)
        let jobCategoryData$ = Observable<[SearchesDataModel]>.just(jobCategoryList)
        
        self.input = Input()
        self.output = Output(recentSearchesData: recentSearchesData$, designCategoryData: designCategoryData$, itDevCategoryData: itDevCategoryData$, jobCategoryData: jobCategoryData$)
    }
}
