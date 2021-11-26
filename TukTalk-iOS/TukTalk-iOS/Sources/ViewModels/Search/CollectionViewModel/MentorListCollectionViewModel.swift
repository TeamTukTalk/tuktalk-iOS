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
        var jobMentorListData: Observable<[MentorListDataModel]>
        
    }
    
    // 서버 연동 후 변경 예정
    var searchingMentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너")
    ]
    var topMentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "리즈", company: "네이버", job: "UXUI 디자인"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너")
    ]
    var jobMentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "에스", company: "삼성전자", job: "AI/머신러닝"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "제인", company: "네이버웹툰", job: "서버"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "한", company: "쿠팡", job: "데이터"),
        MentorListDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "디모", company: "카카오", job: "웹")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let searchingMentorListData$ = Observable<[MentorListDataModel]>.just(searchingMentorList)
        let topMentorListData$ = Observable<[MentorListDataModel]>.just(topMentorList)
        let jobMentorListData$ = Observable<[MentorListDataModel]>.just(jobMentorList)
        self.input = Input()
        self.output = Output(searchingMentorListData: searchingMentorListData$, topMentorListData: topMentorListData$, jobMentorListData: jobMentorListData$)
    }
}
