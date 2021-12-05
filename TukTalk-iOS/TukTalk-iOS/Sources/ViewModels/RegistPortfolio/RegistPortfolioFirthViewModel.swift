//
//  RegistPortfolioFirthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/06.
//

import RxSwift
import RxCocoa
import Moya

struct RegistPortfolioFirthViewModel {
    var formData: [MultipartFormData] = []
    var imgData = BehaviorSubject(value: [])
    private let disposeBag = DisposeBag()
    
    func postPDFRequest(pdfData: Data, fileName: String, status: @escaping (Int) -> (), completion: @escaping (PDFResponse) -> ()) {
        let provider = MoyaProvider<PDFService>()
        provider.rx.request(.pdfRequest(pdfData, fileName: fileName))
            .subscribe { result in
                switch result {
                case let .success(response):
                    status(response.statusCode)
                    guard let responseData = try? response.map(PDFResponse.self) else { return }
                    completion(responseData)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
    func postPreviewRequest(completion: @escaping (PreviewResponse) -> ()) {
        let provider = MoyaProvider<PreviewService>()
        provider.rx.request(.previewRequest(self.formData))
            .subscribe { result in
                switch result {
                case let .success(response):
                    guard let responseData = try? response.map(PreviewResponse.self) else { return }
                    print(response)
                    completion(responseData)
                case let .failure(error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
