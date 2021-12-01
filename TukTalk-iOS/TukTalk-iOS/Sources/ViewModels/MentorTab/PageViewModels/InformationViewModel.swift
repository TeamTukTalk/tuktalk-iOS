//
//  InformationViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import RxSwift
import RxCocoa

final class InformationViewModel:ViewModelType{
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency{
    }
    
    struct Input {
    }
    
    struct Output {
        var introduceCellData: Observable<String>
        var companyCellData: Observable<String>
        var careerCellData: Observable<String>
        var specialtyCellData: Observable<String>
        var tagCellData: Observable<[TagCollectionViewDataModel]>
    }
    
    // 서버 연동 후 변경 예정
    var introduceText = "안녕하세요! 저는 네이버에 다니고 있는 8년 경력의 UXUI 디자이너입니다. 현재는 네이버 UX기획부터 UI 디자인까지 총괄을 하고 있고, 다양한 규모의 스타트업에서 근무하면서 실력을 쌓았습니다."
    
    var companyText = "· (주)회사명 어쩌구 저쩌구~~"
    
    var careerText = "* 땡땡 그룹에서 웹 가이드라인 구축 참여"
    
    var specialtyText = "· UXUI 디자인"
    
    var tagTextList: [TagCollectionViewDataModel] = [
        TagCollectionViewDataModel(title: "#대기업"),
        TagCollectionViewDataModel(title: "#외국계"),
        TagCollectionViewDataModel(title: "#비전공자"),
        TagCollectionViewDataModel(title: "#기업문화"),
        TagCollectionViewDataModel(title: "#노하우"),
        TagCollectionViewDataModel(title: "#실무"),
        TagCollectionViewDataModel(title: "#이직"),
        TagCollectionViewDataModel(title: "#업무체계")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let introduceCellData$ = Observable<String>.just(introduceText)
        let companyCellData$ = Observable<String>.just(companyText)
        let careerCellData$ = Observable<String>.just(careerText)
        let specialtyCellData$ = Observable<String>.just(specialtyText)
        let tagTextList$ = Observable<[TagCollectionViewDataModel]>.just(tagTextList)
        
        self.input = Input()
        self.output = Output(introduceCellData: introduceCellData$, companyCellData: companyCellData$, careerCellData: careerCellData$, specialtyCellData: specialtyCellData$, tagCellData: tagTextList$)
    }
}
