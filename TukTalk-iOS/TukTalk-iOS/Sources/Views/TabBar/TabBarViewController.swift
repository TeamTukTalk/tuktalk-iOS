//
//  TabBarViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK:- Properties
    
    let vc1 = HomeViewController().then {
        $0.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeOffImg"), selectedImage: UIImage(named: "homeOnImg")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let vc2 = SearchMainViewController().then {
        $0.tabBarItem = UITabBarItem(title: "탐색", image: UIImage(named: "searchOffImg"), selectedImage: UIImage(named: "searchOnImg")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let vc3 = CommunityViewController().then {
        $0.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(named: "communityOffImg"), selectedImage: UIImage(named: "communityOffImg")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    let vc4 = ConsultingViewController().then {
        $0.tabBarItem = UITabBarItem(title: "상담", image: UIImage(named: "consultingOffImg"), selectedImage: UIImage(named: "consultingOffImg")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    // 서버연동 후 변경 예정
    let vc5 = MyPageViewController().then {
        $0.tabBarItem = UITabBarItem(title: "마이뚝딱", image: UIImage(named: "mypageOffImg"), selectedImage: UIImage(named: "mypageOnImg")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarLink()
        setTabBarUI()
    }
    
    //MARK:- Function
    
    private func setTabBarUI() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.TTFont(type: .SDMed, size: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.TTFont(type: .SDBold, size: 12)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.GrayScale.normal], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.GrayScale.normal], for: .selected)
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    
    private func setTabBarLink() {
        let nav1 = UINavigationController(rootViewController: vc1).then {
            $0.navigationBar.prefersLargeTitles = true
        }
        let nav2 = UINavigationController(rootViewController: vc2).then {
            $0.navigationBar.prefersLargeTitles = true
        }
        let nav3 = UINavigationController(rootViewController: vc3).then {
            $0.navigationBar.prefersLargeTitles = true
        }
        let nav4 = UINavigationController(rootViewController: vc4).then {
            $0.navigationBar.prefersLargeTitles = true
        }
        let nav5 = UINavigationController(rootViewController: vc5).then {
            $0.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
    }

}
