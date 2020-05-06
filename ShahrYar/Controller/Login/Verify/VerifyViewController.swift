//
//  VerifyViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerifyViewController: UIViewController {
    
    @IBOutlet var smsTextField: UITextField!
    let submitCodeURL = "http://moshkelateshahri.xyz/api/register"
    let defaults = UserDefaults.standard
    var isUserRegisterdBefore = false
    
    func submitVerficationCode() {
        
        var parameters = ["mobile": "", "code": ""]
        
        //    parameters["mobile"] = defaults.string(forKey: "Number")
        parameters["mobile"] = "09904863541"
        parameters["code"] = smsTextField.text
        AF.request(submitCodeURL,
                   method: .post,
                   parameters: parameters).responseJSON { (responseData) -> Void in
                    if((responseData.value) != nil) {
                        let result = JSON(responseData.value!)
                        print(result)
                        print(result["api_token"])
                        //                    self.defaults.set(result["api_token"], forKey: "api_token")
                        if result["profile"].string == nil {
                            print("false")
                            self.isUserRegisterdBefore = false
                        } else {
                            print("true")
                            self.isUserRegisterdBefore = true
                        }
                    }
        }
    }
    
    func checkUser() {
        if isUserRegisterdBefore {
            //bere too view asli
        } else {
            //bere too view register
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        submitVerficationCode()
    }
    
    @IBAction func ChangePhoneNumberButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
