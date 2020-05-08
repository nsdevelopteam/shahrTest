//
//  RegisterViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerTableView: UITableView!
    @IBOutlet var photoHeader: UIView!
    @IBOutlet weak var rightButtonOutlet: UIBarButtonItem!
    let defaults = UserDefaults.standard

    let setProfileURL = "http://moshkelateshahri.xyz/api/setProfile"
    
    let sectionTitles = ["نام و نام خانوادگی", "تاریخ تولد", "جنسیت", "استان", "شهر"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView.tableFooterView = UIView()
        registerTableView.tableHeaderView = photoHeader
        navigationItem.title = "پروفایل"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansMobile-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        rightButtonOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
//
//    func sendDate() {
//        var parameters = ["api_token": "", "name": "", "image": "", "province": "", "city": "", "sex": "", "birthday_day":"", "birthday_month": "", "birthday_year": ""]
//        parameters["api_token"] = defaults.string(forKey: "api_token")
//        parameters["name"] =
//        parameters["image"] =
//        parameters["province"] =
//        parameters["city"] =
//        parameters["sex"] =
//        parameters["birthday_day"] =
//        parameters["birthday_month"] =
//        parameters["birthday_year"] =
//
//        AF.request(setProfileURL,
//                   method: .post,
//                   parameters: parameters).responseJSON { (responseData) -> Void in
//                    if((responseData.value) != nil) {
//                        let result = JSON(responseData.value!)
//                        print(result)
////                        self.hideWaiting()
//                        guard let verifyVc = self.storyboard?.instantiateViewController(withIdentifier: "homeVc") as? VerifyViewController else { return }
//                        self.navigationController?.pushViewController(verifyVc, animated: true)
//                    } else {
////                        self.hideWaiting()
//            }
//        }
//    }
//
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButton(_ sender: Any) {
        print("Submit button Pressed BITCH")
        
        
    }
    
}


extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let registerCell = tableView.dequeueReusableCell(withIdentifier: "resgisterCell", for: indexPath) as! RegisterCell
        
        registerCell.selectionStyle = .none
        
        return registerCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.right
        header.textLabel?.font = UIFont(name: "IRANSansMobile", size: 16)
        header.textLabel?.textColor = .darkGray
        header.tintColor = .clear
    }
}
