//
//  ReviewCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import RxSwift

struct ReviewCollectionViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var reviewListData: Observable<[ReviewDataModel]>
    }
    
    // 추후 변경 예정
    var reviewList: [ReviewDataModel] = [
        ReviewDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "한", company: "쿠팡", job: "데이터", star: UIImage(named: "star5") ?? UIImage(), contents: "궁금했던 내용을 실무 경험으로 얘기해주셔서 너무 도움이 됐습니다. 포트폴리오를 만들려고 하니까 막막했는데 한 멘토님이 어떤 방법으로 제작했는지 디테일하게 얘기해주셔서 너무 좋았습니다. 감사합니다 ㅎㅎ!", menteeName: "애니", date: "2021.10.12"),
        ReviewDataModel(image: UIImage(named: "tempProfileImg") ?? UIImage(), name: "리즈", company: "네이버", job: "데이터", star: UIImage(named: "star4") ?? UIImage(), contents: "궁금했던 내용을 실무 경험으로 얘기해주셔서 너무 도움이 됐습니다. 포트폴리오를 만들려고 하니까 막막했는데 리즈 멘토님이 어떤 방법으로 제작했는지 디테일하게 얘기해주셔서 너무 좋았습니다. 감사합니다 ㅎㅎ!", menteeName: "애니", date: "2021.10.12")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let reviewListData$ = Observable<[ReviewDataModel]>.just(reviewList)
        
        self.input = Input()
        self.output = Output(reviewListData: reviewListData$)
    }
}
