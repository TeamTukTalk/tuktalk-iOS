//
//  MentorInformationViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import RxSwift

final class MentorInformationViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var pageData: Observable<[PageCollectionViewDataModel]>
    }
    
    // 추후 서버연동 후 변경 예정
    
    var pageList: [PageCollectionViewDataModel] = [
        PageCollectionViewDataModel(title: "멘토정보"),
        PageCollectionViewDataModel(title: "포트폴리오"),
        PageCollectionViewDataModel(title: "1:1 멘토링"),
        PageCollectionViewDataModel(title: "후기")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let pageData$ = Observable<[PageCollectionViewDataModel]>.just(pageList)
        
        self.input = Input()
        self.output = Output(pageData: pageData$)
    }
}
