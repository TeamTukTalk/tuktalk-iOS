//
//  LoadingIndicator.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/13.
//

import UIKit

class LoadingView: UIView {
    //MARK:- Properties
    
    private let loadingIndicator = UIImageView().then {
        $0.image = UIImage(named: "indicatorImg")
    }
    private var timer: Timer?
    
    //MARK:- Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        self.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        loadingIndicator.startAnimating()
    }
    
    @objc private func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.loadingIndicator.transform = self.loadingIndicator.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    
    func startLoading() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func finishLoading() {
        timer?.invalidate()
        timer = nil
    }
}

extension UIViewController {
    
    private struct AssociatedKeys {
        static var loadingView: String = "LoadingView"
    }
    
    private var loadingView: LoadingView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? LoadingView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.loadingView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func startLoading() {
        removeLoadingView()
        
        loadingView = LoadingView()
        if let loadingView = loadingView {
            view.addSubview(loadingView)
            loadingView.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.centerX.centerY.equalToSuperview()
            }
        }
        loadingView?.startLoading()
    }
    
    func endLoading() {
        loadingView?.finishLoading()
        removeLoadingView()
    }
    
    private func removeLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
