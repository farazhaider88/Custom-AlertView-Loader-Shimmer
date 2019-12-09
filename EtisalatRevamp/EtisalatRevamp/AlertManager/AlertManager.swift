//
//  AlertManager.swift
//  Swyp
//
//  Created by Faraz Haider on 26/02/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import UIKit
import PopupDialog

enum AlertButtonType {
    case ConstructiveButton
    case DestructiveButton
}


@objc class AlertManager: NSObject {
    @objc open class func showAlert(title: String = "", message: String = "", preferredStyle: UIAlertController.Style = .alert, alertActions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = alertActions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(genericAlertAction())
        }
        UIApplication.shared.keyWindow!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    @objc open class func genericAlertAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    }
    
    
    @objc open class func genericPopupWithOkButton(animated: Bool = true, title:String = "", message:String = "", completion: @escaping () -> Void) {
        
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                tapGestureDismissal: false,
                                panGestureDismissal: false
        ) {
            print("Completed")
        }
        let vc = popup.viewController as! PopupDialogDefaultViewController

        vc.messageFont          = .systemFont(ofSize: 16)
        vc.titleFont          = .systemFont(ofSize: 20)
        let buttonOk = DefaultButton(title: "OK", height: 60){
            completion()
        }
        buttonOk.backgroundColor = UIColor(red: 111/255, green: 154/255, blue: 40/255, alpha: 255/255)
        buttonOk.setTitleColor(UIColor.white, for: .normal)
        buttonOk.titleLabel?.font =  .systemFont(ofSize: 17)
        
        popup.addButtons([buttonOk])
        UIApplication.shared.keyWindow!.rootViewController!.present(popup, animated: false, completion: nil)
    }
    
    
    open class func genericPopupWithConstructiveAndDestructiveButton(animated: Bool = true, title:String = "", message:String = "", constructiveButtonTitle:String = "",destructiveButtonTitle:String = "", completion: @escaping (AlertButtonType) -> Void) {

        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                tapGestureDismissal: false,
                                panGestureDismissal: false
        ) {
            print("Completed")
        }
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.messageFont          = .systemFont(ofSize: 16)
        vc.titleFont          = .systemFont(ofSize: 20)
        
        let destructiveButton = DefaultButton(title: destructiveButtonTitle, height: 60){
            completion(AlertButtonType.DestructiveButton)
        }
        destructiveButton.setTitleColor( UIColor(red: 111/255, green: 154/255, blue: 40/255, alpha: 255/255), for: .normal)
        destructiveButton.titleLabel?.font =  .systemFont(ofSize: 17)
        
        let constructiveButton = CancelButton(title: constructiveButtonTitle, height: 60) {
            completion(AlertButtonType.ConstructiveButton)
        }
        
        constructiveButton.backgroundColor = UIColor(red: 111/255, green: 154/255, blue: 40/255, alpha: 255/255)
        constructiveButton.setTitleColor(UIColor.white, for: .normal)
        constructiveButton.titleLabel?.font =  .systemFont(ofSize: 17)
        
        popup.addButtons([destructiveButton, constructiveButton])
        UIApplication.shared.keyWindow!.rootViewController!.present(popup, animated: false, completion: nil)
    }
    
    
}
