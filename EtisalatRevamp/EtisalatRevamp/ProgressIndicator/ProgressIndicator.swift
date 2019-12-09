//
//  ProgressIndicator.swift
//  EtisalatRevamp
//
//  Created by Faraz Haider on  09/12/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import DGActivityIndicatorView

@objc class ProgressIndicator: UIView {
    // Public properties
    var size: CGFloat = 0.0
    
    // Private members
    private var indicatorView: DGActivityIndicatorView?
    private var bgView: UIView?
    private var shouldShowFullScreen = false
    
  @objc static var sharedInstance: ProgressIndicator = {
        var sharedIndicator = ProgressIndicator()
        sharedIndicator.size = 70
        sharedIndicator.shouldShowFullScreen = true
        return sharedIndicator
    }()
    
    class func shared() -> ProgressIndicator {
        return sharedInstance
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showInScreenIndicator()
    }
    
    func showInScreenIndicator() {
        shouldShowFullScreen = false
        indicatorView = getIndicatorWithSize(min(bounds.size.width, bounds.size.height))
        indicatorView?.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        indicatorView?.startAnimating()
        if let indicator = indicatorView {
            addSubview(indicator)
        }
    }
    
    
   @objc func show(asFullScreen shouldFullScreen: Bool = true) {
        shouldShowFullScreen = shouldFullScreen
        DispatchQueue.main.async(execute: {
            if self.indicatorView?.animating == nil || self.indicatorView?.animating == false {
                self.indicatorView = self.getIndicatorWithSize(self.size)
                self.indicatorView?.startAnimating()
                if let indicatorView = self.indicatorView {
                    UIApplication.shared.keyWindow?.addSubview(indicatorView)
                }
            }
        })
    }
    
   @objc func hide() {
        DispatchQueue.main.async(execute: {
            self.bgView?.removeFromSuperview()
            self.indicatorView?.stopAnimating()
            self.indicatorView?.removeFromSuperview()
        })
    }
    
    func isAnimating() -> Bool {
        return indicatorView?.animating ?? false
    }
    
    func getIndicatorWithSize(_ size: CGFloat) -> DGActivityIndicatorView {
        let indicatorView = createIndicatorView(withSize: size)
        if shouldShowFullScreen {
            let screenSize = UIScreen.main.bounds
            bgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.size.width, height: screenSize.size.height))
            
            if let bg = bgView {
                bg.backgroundColor = UIColor(white: 1, alpha: 0.75)
                UIApplication.shared.keyWindow?.addSubview(bg)
            }
        }
        return indicatorView
    }
    
    func createIndicatorView(withSize size: CGFloat) -> DGActivityIndicatorView {
        let screenSize = UIScreen.main.bounds
        let activityIndicatorView = DGActivityIndicatorView(type: .ballSpinFadeLoader, tintColor: UIColor(hex: "7b9c36"), size: size)
        let frame = CGRect(x: 0, y: 0, width: screenSize.size.width, height: screenSize.size.height)
        activityIndicatorView?.frame = CGRect(x: 0, y: 0, width: screenSize.size.width, height: screenSize.size.height)
        if let center = UIApplication.shared.keyWindow?.rootViewController?.view.center {
            activityIndicatorView?.center = center
        }
        UIApplication.shared.keyWindow?.rootViewController?.view.endEditing(true)
        return activityIndicatorView ?? DGActivityIndicatorView(frame: frame)
    }
}
