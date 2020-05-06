//
//  IntroViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class IntroViewController: UIViewController {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var sendSMSOutlet: UIButton!
    
    let verifyURL = "http://moshkelateshahri.xyz/api/verify"
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    var indicatorView = UIView()
    var container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        
        sendSMSOutlet.layer.cornerRadius = 5
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "بازگشت", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem!.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 17)!], for: UIControl.State.normal)
    }
    
    @IBAction func sendSMS(_ sender: UIButton) {
//        showWaiting()
//        sendSMSRequest()
        
        guard let verifyVc = self.storyboard?.instantiateViewController(withIdentifier: "verifyVc") as? VerifyViewController else { return }
        self.navigationController?.pushViewController(verifyVc, animated: true)
    }
    
    
    func sendSMSRequest() {
        var parameters = ["mobile": ""]
        parameters["mobile"] = numberField.text
        defaults.set(numberField.text, forKey: "Number")
        
        AF.request(verifyURL,
                   method: .post,
                   parameters: parameters).responseJSON { (responseData) -> Void in
                    if((responseData.value) != nil) {
                        let result = JSON(responseData.value!)
                        print(result)
                        self.hideWaiting()
                        guard let verifyVc = self.storyboard?.instantiateViewController(withIdentifier: "verifyVc") as? VerifyViewController else { return }
                        self.navigationController?.pushViewController(verifyVc, animated: true)
                    } else {
                        self.hideWaiting()
                    }
        }
    }
}

extension IntroViewController {
    
    func hideNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    func showWaiting() {
        let screenSize = UIScreen.main.bounds
        DispatchQueue.main.async {
            self.container.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            self.container.backgroundColor = UIColor(white: 0, alpha: 0.0)
            
            self.indicatorView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.indicatorView.center = self.container.center
            self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.indicatorView.clipsToBounds = true
            self.indicatorView.layer.cornerRadius = 10
            
            let indicatorViewSize = self.indicatorView.frame.size
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.center = CGPoint(x: indicatorViewSize.width/2, y: indicatorViewSize.height/2)
            
            self.indicatorView.addSubview(self.activityIndicator)
            self.container.addSubview(self.indicatorView)
            self.activityIndicator.startAnimating()
            
            UIView.animate(withDuration: 0.2) {
                self.container.backgroundColor = UIColor(white: 0, alpha: 0.3)
                self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.7)
                UIApplication.shared.keyWindow?.addSubview(self.container)
            }
        }
    }
    
    func hideWaiting() {
        DispatchQueue.main.async {
            self.container.backgroundColor = UIColor(white: 0, alpha: 0.3)
            self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            UIView.animate(withDuration: 0.2) {
                self.container.backgroundColor = UIColor(white: 0, alpha: 0.0)
                self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.container.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                
            }
        }
    }
    
    func InternetError() {
        let internetErrorAlert = UIAlertController(title: "اخطار", message: "لطفا اتصال خود را به اینترنت بررسی کنید.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "فهمیدم", style: .cancel, handler: nil)
        internetErrorAlert.addAction(closeAction)
        present(internetErrorAlert, animated: true)
    }
}
