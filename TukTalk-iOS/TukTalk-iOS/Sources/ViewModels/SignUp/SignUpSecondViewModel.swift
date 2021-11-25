//
//  WhichFieldViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import RxSwift

final class SignUpSecondViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var selectedNum: AnyObserver<Int>
    }
    
    struct Output {
        var designData: Observable<[FieldCategoryDataModel]>
        var itDevData: Observable<[FieldCategoryDataModel]>
        var nextBtnEnable: Observable<Bool>
    }
    
    var designDataList: [FieldCategoryDataModel] = [
        FieldCategoryDataModel(category: "로고/브랜딩"),
        FieldCategoryDataModel(category: "UXUI 디자인"),
        FieldCategoryDataModel(category: "웹 디자인"),
        FieldCategoryDataModel(category: "편집 디자인"),
        FieldCategoryDataModel(category: "일러스트/캐릭터 디자인"),
        FieldCategoryDataModel(category: "제품/산업디자인")
    ]
    
    var itDevDataList: [FieldCategoryDataModel] = [
        FieldCategoryDataModel(category: "웹 개발"),
        FieldCategoryDataModel(category: "앱 개발"),
        FieldCategoryDataModel(category: "서버 개발"),
        FieldCategoryDataModel(category: "IT/기술"),
        FieldCategoryDataModel(category: "게임"),
        FieldCategoryDataModel(category: "머신러닝/데이터")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let selectedNum$ = BehaviorSubject<Int>(value: 0)
        let nextBtnEnable$ = btnValidation(selectedNum: selectedNum$)
        let designData$ = Observable<[FieldCategoryDataModel]>.just(designDataList)
        let itDevData$ = Observable<[FieldCategoryDataModel]>.just(itDevDataList)
        
        self.input = Input(selectedNum: selectedNum$.asObserver())
        self.output = Output(designData: designData$, itDevData: itDevData$, nextBtnEnable: nextBtnEnable$)
    }
}

private func btnValidation(selectedNum: Observable<Int>) -> Observable<Bool> {
    return selectedNum.map { num in
        return num > 0
    }
}
