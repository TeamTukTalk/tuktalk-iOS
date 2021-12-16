//
//  PortfolioPreviewView.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/15.
//

import UIKit

class PortfolioPreviewView: UIViewController {
    
    //MARK:- Properties
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        setUI()
    }
    
    //MARK:- Function
    
    private func setGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragDownDissmiss(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    private func setUI() {
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.height.width.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func dragDownDissmiss(_ panG: UIPanGestureRecognizer) {
        let trY = panG.translation(in: panG.view!).y
        switch panG.state {
        case .began:
            break
        case .changed:
            view.transform = CGAffineTransform(translationX: 0, y: trY)
        case .ended, .cancelled:
            if trY > 160 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}
