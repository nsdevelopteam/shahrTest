//
//  VerifyViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Alamofire

class VerifyViewController: UIViewController {
    
    @IBOutlet var smsTextField: UITextField!
    let submitCodeURL = "http://moshkelateshahri.xyz/api/register"
    
    
    func submitVerficationCode() {
        
        //az view qbli shomare mobile o pass bde inja
        
        var parameters = ["mobile": "", "code": ""]
        
        parameters["code"] = smsTextField.text
        AF.request(submitCodeURL, method: .post, parameters: parameters).response { response in
        debugPrint(response)
        }
    }
    
    
   @IBAction func submitButton(_ sender: Any) {
        submitVerficationCode()
    }
    
    @IBAction func ChangePhoneNumberButton(_ sender: Any) {
        //Back to previous VC
    }
}
