//
//  SignUpMenteeViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

struct AgreeButtonViewModel {
    let output: Output
    var toggle = false
    
    struct Output {
        var imgChange = false
    }
    
    init() {
        self.output = Output(imgChange: toggle)
    }
    
    mutating func btnToggle() {
        toggle.toggle()
    }
    
}
