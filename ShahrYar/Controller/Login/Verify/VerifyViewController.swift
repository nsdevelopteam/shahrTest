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
    @IBOutlet weak var verifyOutlet: UIButton!
    @IBOutlet weak var changePhoneNumberOutlet: UIButton!
    
    let submitCodeURL = "http://moshkelateshahri.xyz/api/register"
    let defaults = UserDefaults.standard
    var isUserRegisterdBefore = false
    var api_token = ""
//    var Username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyOutlet.layer.cornerRadius = 5
        changePhoneNumberOutlet.layer.cornerRadius = 5
    }
    
    func submitVerficationCode() {
        
        var parameters = ["mobile": "", "code": ""]
        let smsCode = smsTextField.text
        parameters["mobile"] = defaults.string(forKey: "Number")
        parameters["code"] = smsCode?.transformNumbersToEng()
        AF.request(submitCodeURL,
                   method: .post,
                   parameters: parameters).responseJSON { (responseData) -> Void in
                    if((responseData.value) != nil) {
                        let result = JSON(responseData.value!)
                        print(result)
                        print(result["api_token"])
                        self.api_token = result["api_token"].stringValue
                        if result["profile"] == JSON.null {
                            self.isUserRegisterdBefore = false
                        } else {
                            self.isUserRegisterdBefore = true
                            print(result["profile"]["name"].stringValue)
                            self.defaults.set(result["profile"]["name"].stringValue, forKey: "Name")
                        }
                    }
        }
            self.defaults.set(api_token, forKey: "api_token")
    }
    
    func checkUser() {
        if isUserRegisterdBefore {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeVc")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "registerVc")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        submitVerficationCode()
        checkUser()
    }
    
    @IBAction func ChangePhoneNumberButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
