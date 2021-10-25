//
//  RecentSearchViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import Foundation
import RxSwift

final class RecentSearchesViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var collectionData : Observable<[RecentSearchesDataModel]>
    }
    
    var recentSearchesList: [RecentSearchesDataModel] = [
        // 추후 서버연동 후 변경 예정
        RecentSearchesDataModel(title: "로고/브랜딩"),
        RecentSearchesDataModel(title: "스타트업"),
        RecentSearchesDataModel(title: "디자이너"),
        RecentSearchesDataModel(title: "대기업"),
        RecentSearchesDataModel(title: "카카오"),
        RecentSearchesDataModel(title: "개발")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let collectionData$ = Observable<[RecentSearchesDataModel]>.just(recentSearchesList)
        
        self.input = Input()
        self.output = Output(collectionData: collectionData$)
    }
}
