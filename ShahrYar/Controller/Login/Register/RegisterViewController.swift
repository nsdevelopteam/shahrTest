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
    
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var registerTableView: UITableView!
    @IBOutlet var photoHeader: UIView!
    @IBOutlet weak var rightButtonOutlet: UIBarButtonItem!
    let defaults = UserDefaults.standard
    
    //Variables
    var api_token = ""
    var name = ""
//    var image
    var province: [String] = []
    var cities: [String] = []
//    var city: [] //array
    var sex = ["male", "female"]
    var birthday_day: Int = 0
    var birthday_month: Int = 0
    var birthday_year: Int = 0
    
    
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
        getCity(provinceID: chosenProvince)
        
//        getProfileData(api_token: defaults.string(forKey: "api_token")!)
        
//        let testToken = "GihrnWP3rxmkplX57xPUHIhIGW43Pduz5tVooCCE0cjpncpY9psc3zKt3fnkZUfg0cMKUkyQIqwRFVJ0rGYbNJj8RUU8nYH5bE74"
        let testToken = "zSGU80KJP41LnP8SdVM1UalIoe6GcdQ6QsA8SXUYkQVrlYEBY7nqFBT9ndGEv6GPFUd6N8CtOaYffwcge7Jq47RGLysOE8enwfOJ" //RaziPour token
        
        sendDate(api_token: testToken, name: "wwwwww", province: "گلستان", city: "گرگان", sex: "male", BDDay: "1", BDMonth: "2", BDYear: "1377")

        getProfileData(api_token: testToken)


    }
    
    func getProvince() {
        AF.request(provinceURL,
           method: .get).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
                self.province = result[0].arrayValue.map {$0[0].stringValue}
                for (_, res) in result {
                    self.province.append(res["name"].string ?? "استان")
                }
            }
        }
    }
    
    
    func getProfileData(api_token: String) {
        var parameters = ["api_token": ""]
        parameters["api_token"] = api_token
        let cityURL = "http://moshkelateshahri.xyz/api/getProfile/"
        AF.request(cityURL,
           method: .get, parameters: parameters).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
                print(result)
            }
        }
    }
    
    
    func getCity(provinceID: String) {
        
        let cityURL = "http://moshkelateshahri.xyz/api/provinces/" + provinceID + "/cities"
        AF.request(cityURL,
           method: .get).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
                print(result)
                for (_, res) in result {
                    print(res["name"])
                    self.cities.append(res["name"].string ?? "شهر")
                    print(self.cities)
                }
            }
        }
    }
    


    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func sendDate(api_token: String, name: String, province: String, city: String, sex: String, BDDay: String, BDMonth: String, BDYear: String) {

//        var parameters = ["api_token": "", "name": "", "image": "", "province": "", "city": "", "sex": "", "birthday_day":"", "birthday_month": "", "birthday_year": ""]

//        var parameters = ["api_token": "", "name": "", "image": "", "province": "", "city": "", "sex": "", "birthday_day":"", "birthday_month": "", "birthday_year": ""]

        let parameters = ["api_token": api_token, "name": name, "province": province, "city": city, "sex": sex, "birthday_day": BDDay, "birthday_month": BDMonth, "birthday_year": BDYear]
//        let image = UIImage(named: "image.png")
        let url = NSURL(string: setProfileURL)

        postComplexPictures(url: url! as URL, params: parameters, pictures: #imageLiteral(resourceName: "problem-1"))
        
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
    }

          func postComplexPictures(url:URL, params:[String:Any], pictures : UIImage) {
              
              let headers: HTTPHeaders
              headers = ["Content-type": "multipart/form-data"]
              
              AF.upload(multipartFormData: { (multipartFormData) in
                  
                  for (key, value) in params {
                      print("key : \(key), value \(value)")
                      multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                  }
                  
                  //let resizeImage: UIImage = self.videoCapture.resizeImage(image: pictures, targetSize: CGSize(width: 720, height: 1280))
                  if let imageData = pictures.pngData()
                  {
                      multipartFormData.append(imageData, withName: "problem-6.png", fileName: "problem-6.png", mimeType: "image/jpg")
                  }
              }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
                  .responseJSON
                  {
                      response in
                      //debugPrint(response)
                      switch response.result
                      {
                          
                      case .success(let value):
                          print("value : \(value)")
                          do
                          {
                            print("eaweaweaweaeawewaeaweaw")
//                              let parsedData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
//                              let getvalue = try JSONDecoder().decode(fitme.self, from: parsedData)
//                              print(getvalue.result)
                              
                          } catch {
                            print(error)
                          }
                          
                      case .failure(let error):
                          print("error 발생 : \(error)")
                          break
                      }
                      
              }
              
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
    
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func submitButton(_ sender: Any) {
        print("Submit button Pressed")
        print(name)
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

        
        
        registerCell.nameTextField.delegate = self
        registerCell.dayTextField.delegate = self
        registerCell.monthTextField.delegate = self
        registerCell.yearTextField.delegate = self
        registerCell.dropDownSex.delegate = self
        registerCell.dropDownProvince.delegate = self
        registerCell.dropDownCity.delegate = self

        registerCell.nameTextField.tag = indexPath.row
        
        //Fucking TableView Setting wowowohahaha

        switch indexPath.row {
        case 0: //Name
            print("1")
            registerCell.nameTextField.isHidden = false
        case 1: //Birthday
            print("2")
            registerCell.dayTextField.isHidden = false
            registerCell.monthTextField.isHidden = false
            registerCell.yearTextField.isHidden = false
        case 2: //Sex
            print("3")
            registerCell.dropDownSex.isHidden = false
        case 3: //Province
            print("4")
            registerCell.dropDownProvince.isHidden = false
        case 4: //City
            registerCell.dropDownCity.isHidden = false
        default:
            break
        }

        
        
//        DispatchQueue.main.async {
//
//                    switch indexPath.row {
//            //        case 0: //Name
//            //            registerCell.nameTextField.isHidden = false
//                    case 1: //Birthday
//                        registerCell.dayTextField.isHidden = false
//                        registerCell.monthTextField.isHidden = false
//                        registerCell.yearTextField.isHidden = false
//                    case 2: //Sex
//                        registerCell.dropDownSex.isHidden = false
//                    case 3: //Province
//                        registerCell.dropDownProvince.isHidden = false
//                    case 4: //City
//                        registerCell.dropDownCity.isHidden = false
//                    default:
//                        break
//                    }
////        if indexPath.row == 0 {
////            registerCell.dayTextField.isHidden = false
////             registerCell.monthTextField.isHidden = false
////             registerCell.yearTextField.isHidden = false
////        } else if indexPath.row == 1 {
////            registerCell.dropDownCity.isHidden = false
////
////        }
//        }
        //End of Fucking TableView Setting wowowohahaha
        
        registerCell.dropDownProvince.tag = (indexPath.row + 100)

        if registerCell.dropDownProvince.tag == 100 +  0 {
            registerCell.dropDownProvince.listWillAppear {
                registerCell.dropDownProvince.optionArray = self.province
            }
            registerCell.dropDownProvince.didSelect{(selectedText , index ,id) in
                let provinceID = Int(index) + 1
                self.chosenProvince = String(provinceID)
            }
        }
        
        if registerCell.dropDownProvince.tag == 100 + 1 {
            registerCell.dropDownProvince.listWillAppear {
                registerCell.dropDownProvince.optionArray = self.cities
            }
//            registerCell.dropDownProvince.didSelect{(selectedText , index ,id) in
//                let provinceID = Int(index) + 1
//                self.chosenProvince = String(provinceID)
//            }
        }
        
        

    
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
