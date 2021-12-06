//
//  SpecialityViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/13.
//

import RxSwift

final class FieldViewModel:ViewModelType{
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var selectedBtn: AnyObserver<String>
        var selectedField: AnyObserver<String>
    }
    
    struct Output {
        var fieldData: Observable<[FieldTableViewDataModel]>
    }
    // 서버 연동 후 변경 예정
    var specialityList: [FieldTableViewDataModel] = [
        FieldTableViewDataModel(title: "디자인"),
        FieldTableViewDataModel(title: "IT/개발")
    ]
    var designDetailList: [FieldTableViewDataModel] = [
        FieldTableViewDataModel(title: "UXUI 디자인"),
        FieldTableViewDataModel(title: "웹 디자인"),
        FieldTableViewDataModel(title: "브랜드 디자인"),
        FieldTableViewDataModel(title: "그래픽 디자인"),
        FieldTableViewDataModel(title: "산업/제품 디자인")
    ]
    var itDevDetailList: [FieldTableViewDataModel] = [
        FieldTableViewDataModel(title: "앱"),
        FieldTableViewDataModel(title: "웹"),
        FieldTableViewDataModel(title: "IT/기술직군"),
        FieldTableViewDataModel(title: "서버"),
        FieldTableViewDataModel(title: "AI/머신러닝"),
        FieldTableViewDataModel(title: "데이터"),
        FieldTableViewDataModel(title: "게임")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let selectedBtn$ = BehaviorSubject(value: "")
        let selectedField$ = BehaviorSubject(value: "")
        let fieldData$ = getData(selectedBtn: selectedBtn$, selectedField: selectedField$, speciality: specialityList, design: designDetailList, itDev: itDevDetailList)
        
        self.input = Input(selectedBtn: selectedBtn$.asObserver(), selectedField: selectedField$.asObserver())
        self.output = Output(fieldData: fieldData$)
    }
}

private func getData(selectedBtn: Observable<String>, selectedField: Observable<String>, speciality: [FieldTableViewDataModel], design: [FieldTableViewDataModel], itDev: [FieldTableViewDataModel]) -> Observable<[FieldTableViewDataModel]> {
    return selectedBtn.map { btn in
        if btn == "specialityBtn" {
            return speciality
        } else {
            var data: [FieldTableViewDataModel] = []
            selectedField.subscribe(onNext: { field in
                if field == "디자인" {
                    data = design
                } else {
                    data = itDev
                }
            })
            .disposed(by: DisposeBag())
            return data
        }
    }
}
