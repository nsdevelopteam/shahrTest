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
        
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func sendSMS() {
        var parameters = ["mobile": ""]
        parameters["mobile"] = numberField.text
    
        
        AF.request(verifyURL,
                   method: .post,
                   parameters: parameters).responseJSON { (responseData) -> Void in
                    if((responseData.value) != nil) {
                        let result = JSON(responseData.value!)
                print(result)
            }
        }
    }
    

    
    @IBAction func sendSMS(_ sender: UIButton) {
        sendSMS()
    }
}

