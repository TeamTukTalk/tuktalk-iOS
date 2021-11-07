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
        var mentorListData: Observable<[MentorListDataModel]>
        
    }
    
    // 서버 연동 후 변경 예정
    var mentorList: [MentorListDataModel] = [
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
        MentorListDataModel(image: UIImage(named: "mypageOffImg") ?? UIImage(), name: "제이슨", company: "네이버", job: "UXUI 디자이너"),
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let mentorListData$ = Observable<[MentorListDataModel]>.just(mentorList)
        
        self.input = Input()
        self.output = Output(mentorListData: mentorListData$)
    }
}
