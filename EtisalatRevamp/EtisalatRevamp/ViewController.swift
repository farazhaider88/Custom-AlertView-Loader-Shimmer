//
//  ViewController.swift
//  EtisalatRevamp
//
//  Created by Faraz Haider on 09/12/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import UIKit
import ListPlaceholder

class ViewController: UIViewController {
    @IBOutlet weak var shimmerView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showLoaderClicked(_ sender: Any) {
        ProgressIndicator.shared().show(asFullScreen: true)
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hideLoader), userInfo: nil, repeats: false)
    }
    
    @objc func hideLoader() {
        ProgressIndicator.shared().hide()
    }
    
    @IBAction func showAlertClicked(_ sender: Any) {
        //        AlertManager.showAlert(title: "EtisalatRevamp", message: Constants.Error.genericErrorMessage)
        AlertManager.genericPopupWithOkButton(animated: true, title: Constants.Error.networkErrorTitle, message: Constants.Error.networkErrorMessage) {
            print("Ok Button Clicked")
        }
    }
    
    @IBAction func showAlertClickedWithOkAndCancel(_ sender: Any)  {
    AlertManager.genericPopupWithConstructiveAndDestructiveButton(animated: true, title: Constants.Error.networkErrorTitle, message: Constants.Error.networkErrorMessage, constructiveButtonTitle: "OK", destructiveButtonTitle: "CANCEL" ) { (buttonType) in
            switch buttonType {
            case .DestructiveButton:
                print("Destructive button clicked")
            case .ConstructiveButton:
                print("Constructive bsutton clicked")
            }
        }
    }
    
    @IBAction func showShimmerView(_ sender: Any)  {
        shimmerView.showLoader()
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController.removeLoader), userInfo: nil, repeats: false)
    }
    
    @objc func removeLoader(){
        shimmerView.hideLoader()
    }

}

