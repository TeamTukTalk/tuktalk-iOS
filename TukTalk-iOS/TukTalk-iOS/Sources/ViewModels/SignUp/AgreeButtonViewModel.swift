//
//  SignUpMenteeViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

struct AgreeButtonViewModel {
    let dependency: Dependency
    let output: Output
    var toggle = false
    
    struct Dependency {
        var isSelected: Bool?
    }
    
    struct Output {
        var imgChange = false
    }
    
    init(dependency: Dependency = Dependency(isSelected: nil)) {
        self.dependency = dependency
        self.output = Output(imgChange: toggle)
    }
    
    mutating func btnToggle() {
        toggle.toggle()
    }
    
}
