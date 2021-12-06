//
//  TagCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift

final class TagCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var companyCategoryData: Observable<[TagCollectionViewDataModel]>
        var hashTagCategoryData: Observable<[TagCollectionViewDataModel]>
    }
    
    // 추후 서버연동 후 변경 예정
    
    var companyCategoryList: [TagCollectionViewDataModel] = [
        TagCollectionViewDataModel(title: "#대기업"),
        TagCollectionViewDataModel(title: "#중견기업"),
        TagCollectionViewDataModel(title: "#중소기업"),
        TagCollectionViewDataModel(title: "#스타트업"),
        TagCollectionViewDataModel(title: "#프리랜서")
    ]
    
    var hashTagCategoryList: [TagCollectionViewDataModel] = [
        TagCollectionViewDataModel(title: "#이직"),
        TagCollectionViewDataModel(title: "#외국계"),
        TagCollectionViewDataModel(title: "#주니어"),
        TagCollectionViewDataModel(title: "#시니어"),
        TagCollectionViewDataModel(title: "#합격포트폴리오"),
        TagCollectionViewDataModel(title: "#비전공자"),
        TagCollectionViewDataModel(title: "#진로고민"),
        TagCollectionViewDataModel(title: "#노하우"),
        TagCollectionViewDataModel(title: "#업무체계"),
        TagCollectionViewDataModel(title: "#기업문화"),
        TagCollectionViewDataModel(title: "#실무"),
        TagCollectionViewDataModel(title: "#프로덕트디자인"),
        TagCollectionViewDataModel(title: "#UX"),
        TagCollectionViewDataModel(title: "#GUI"),
        TagCollectionViewDataModel(title: "#상담"),
        TagCollectionViewDataModel(title: "#피드백"),
        TagCollectionViewDataModel(title: "#캐릭터")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let companyCategoryData$ = Observable<[TagCollectionViewDataModel]>.just(companyCategoryList)
        let hashTagCategoryData$ = Observable<[TagCollectionViewDataModel]>.just(hashTagCategoryList)
        
        self.input = Input()
        self.output = Output(companyCategoryData: companyCategoryData$, hashTagCategoryData: hashTagCategoryData$)
    }
}
