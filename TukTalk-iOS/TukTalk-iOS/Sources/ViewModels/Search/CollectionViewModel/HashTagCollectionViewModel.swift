//
//  HashTagCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/31.
//

import RxSwift

final class HashTagCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var hashTagListData: Observable<[SearchesDataModel]>
        
    }
    
    // 서버 연동 후 변경 예정
    var hashTagList: [SearchesDataModel] = [
        SearchesDataModel(title: "#8년차"),
        SearchesDataModel(title: "#대기업"),
        SearchesDataModel(title: "#B2B"),
        SearchesDataModel(title: "#디자이너"),
        SearchesDataModel(title: "#실무"),
        SearchesDataModel(title: "#UXUI"),
        SearchesDataModel(title: "#대기업 합격"),
        SearchesDataModel(title: "#IT")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let hashTagListData$ = Observable<[SearchesDataModel]>.just(hashTagList)
        
        self.input = Input()
        self.output = Output(hashTagListData: hashTagListData$)
    }
}
