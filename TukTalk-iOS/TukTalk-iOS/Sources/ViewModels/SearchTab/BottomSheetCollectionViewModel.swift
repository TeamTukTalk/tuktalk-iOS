//
//  BottomSheetViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/28.
//

import RxSwift

final class BottomSheetCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var companyListData: Observable<[SearchesDataModel]>
        var careerListData: Observable<[SearchesDataModel]>
        
    }
    
    var companyList: [SearchesDataModel] = [
        SearchesDataModel(title: "대기업"),
        SearchesDataModel(title: "중견기업"),
        SearchesDataModel(title: "중소기업"),
        SearchesDataModel(title: "스타트업"),
        SearchesDataModel(title: "프리랜서")
    ]
    
    var careerList: [SearchesDataModel] = [
        SearchesDataModel(title: "1~2년"),
        SearchesDataModel(title: "3~4년"),
        SearchesDataModel(title: "5~6년"),
        SearchesDataModel(title: "7~8년"),
        SearchesDataModel(title: "9년 이상")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let companyListData$ = Observable<[SearchesDataModel]>.just(companyList)
        let careerListData$ = Observable<[SearchesDataModel]>.just(careerList)
        
        self.input = Input()
        self.output = Output(companyListData: companyListData$, careerListData: careerListData$)
    }
}
