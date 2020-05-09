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
import iOSDropDown

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var registerTableView: UITableView!
    @IBOutlet var photoHeader: UIView!
    @IBOutlet weak var rightButtonOutlet: UIBarButtonItem!
    let defaults = UserDefaults.standard

    //    dropDown.optionArray = ["Option 1", "Option 2", "Option 3"]

    
    //Variables
    var api_token = ""
    var name = ""
//    var image
    var province: [String] = [] // array
//    var city: [] //array
    var sex = ["male", "female"]
    var birthday_day: Int = 0
    var birthday_month: Int = 0
    var birthday_year: Int = 0
    

    
    
    var indexPath: IndexPath = []
    
    var chosenProvince: String = "1"

    let setProfileURL = "http://moshkelateshahri.xyz/api/setProfile"
    let provinceURL = "http://moshkelateshahri.xyz/api/provinces"
    let sectionTitles = ["نام و نام خانوادگی", "تاریخ تولد", "جنسیت", "استان", "شهر"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView.tableFooterView = UIView()
        registerTableView.tableHeaderView = photoHeader
        navigationItem.title = "پروفایل"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansMobile-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        rightButtonOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        
        getProvince()
        getCity(provinceID: "1")

    }
    
    func getProvince() {
        AF.request(provinceURL,
           method: .get).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
//                print(result)
                self.province = result[0].arrayValue.map {$0[0].stringValue}
//                print(result[0]["name"])
                for (_, res) in result {
//                    print(res["name"])
                    self.province.append(res["name"].string ?? "استان")
//                    print(index)
                }
            }
        }
    }
    
    
    func getCity(provinceID: String) {
        
        let cityURL = "http://moshkelateshahri.xyz/api/provinces/" + provinceID + "/cities"
//        let cityURL = "http://moshkelateshahri.xyz/api/provinces/1/cities"
        AF.request(cityURL,
           method: .get).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
                print(result)
//                self.province = result[0].arrayValue.map {$0[0].stringValue}
//                print(result[0]["name"])
//                for (_, res) in result {
//                    print(res["name"])
//                    self.province.append(res["name"].string ?? "استان")
//                    print(index)
                }
            }
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
    
    func fetchFilms() {

      }
    
    @IBAction func submitButton(_ sender: Any) {
        print("Submit button Pressed")
        print(name)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField.tag {
        case 0: //name
            print(textField.text!)
            name = textField.text!
        case 1: //birthday
            print(textField.text!)
            name = textField.text!
//        case 2: //sex
//            sex =
//        case 3: // province
//
//        case 4: //city
//
        default:
            break
        }
        
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

        
        registerCell.dropDownMenu.optionArray = province
        
        registerCell.textField.delegate = self
        registerCell.textField.tag = indexPath.row
        
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
