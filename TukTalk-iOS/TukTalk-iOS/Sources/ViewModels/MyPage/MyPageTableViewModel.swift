//
//  MyActivityTableViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/02.
//

import Foundation
import RxSwift

final class MyPageTableViewModel:ViewModelType{
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency{
    }
    
    struct Input {
    }
    
    struct Output {
        var mentorActivityData: Observable<[MyPageTVDataModel]>
        var mentorServiceData: Observable<[MyPageTVDataModel]>
        var menteeActivityData: Observable<[MyPageTVDataModel]>
        var menteeServiceData: Observable<[MyPageTVDataModel]>
    }
    
    var mentorActivityList: [MyPageTVDataModel] = [
        MyPageTVDataModel(title: "수익관리"),
        MyPageTVDataModel(title: "내 계좌"),
        MyPageTVDataModel(title: "질문/답변"),
        MyPageTVDataModel(title: "멘토/회사 인증하기")
    ]
    var mentorServiceList: [MyPageTVDataModel] = [
        MyPageTVDataModel(title: "공지사항"),
        MyPageTVDataModel(title: "자주 묻는 질문"),
        MyPageTVDataModel(title: "뚝딱에 문의하기"),
        MyPageTVDataModel(title: "뚝딱 서비스 소개"),
        MyPageTVDataModel(title: "친구초대"),
        MyPageTVDataModel(title: "계정 설정")
    ]
    var menteeActivityList: [MyPageTVDataModel] = [
        MyPageTVDataModel(title: "리뷰관리"),
        MyPageTVDataModel(title: "문의내역"),
        MyPageTVDataModel(title: "결제/환불 내역")
    ]
    var menteeServiceList: [MyPageTVDataModel] = [
        MyPageTVDataModel(title: "공지사항"),
        MyPageTVDataModel(title: "자주 묻는 질문"),
        MyPageTVDataModel(title: "뚝딱에 문의하기"),
        MyPageTVDataModel(title: "뚝딱 서비스 소개"),
        MyPageTVDataModel(title: "멘토/회사 인증하기"),
        MyPageTVDataModel(title: "친구초대"),
        MyPageTVDataModel(title: "계정 설정")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let mentorActivityData$ = Observable<[MyPageTVDataModel]>.just(mentorActivityList)
        let mentorServiceData$ = Observable<[MyPageTVDataModel]>.just(mentorServiceList)
        let menteeActivityData$ = Observable<[MyPageTVDataModel]>.just(menteeActivityList)
        let menteeServiceData$ = Observable<[MyPageTVDataModel]>.just(menteeServiceList)
        
        self.input = Input()
        self.output = Output(mentorActivityData: mentorActivityData$, mentorServiceData: mentorServiceData$, menteeActivityData: menteeActivityData$, menteeServiceData: menteeServiceData$)
    }

}
