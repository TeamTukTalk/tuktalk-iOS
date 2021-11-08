//
//  MentorListCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/31.
//

import RxSwift

final class MentorListCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var searchingMentorListData: Observable<[MentorListDataModel]>
        var topMentorListData: Observable<[MentorListDataModel]>
        
    }
    
    // 서버 연동 후 변경 예정
    var searchingMentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
    ]
    var topMentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "리즈", company: "네이버", job: "UXUI 디자인"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let searchingMentorListData$ = Observable<[MentorListDataModel]>.just(searchingMentorList)
        let topMentorListData$ = Observable<[MentorListDataModel]>.just(topMentorList)
        self.input = Input()
        self.output = Output(searchingMentorListData: searchingMentorListData$, topMentorListData: topMentorListData$)
    }
}
