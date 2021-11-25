//
//  UIViewControllerExtension.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/05.
//

import UIKit

extension UIViewController {
    @objc func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupAppearance() {
        navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}
