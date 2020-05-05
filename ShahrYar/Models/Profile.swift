//
//  Profile.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import SwiftyJSON

class Profile {
    
    var mobile: String!
    var isActive:Bool!
    var token: String!
    var userID: Int!
    var id: Int?
    var name: String?
    var gender: Gender = .female
    var profileImage: String?
    var provinceName: String?
    var cityName: String?
    var birthdate: Date?
    var city: City?
    var imageFile: UIImage?
    
    init() {}
    
    init(_ json: JSON) {
        self.mobile = json["mobile"].stringValue
        self.isActive = json["is_active"].boolValue
        self.token = json["api_token"].stringValue
        self.userID = json["id"].intValue
        
        let profile: JSON? = json["profile"]
        if profile != nil {
            self.id = profile!["id"].int
            self.name = profile!["name"].string
            self.gender = Gender(rawValue: profile!["sex"].stringValue) ?? .man
            self.profileImage = profile!["image"].string
            self.provinceName = profile!["province"].string
            self.cityName = profile!["city"].string
            
            if let day = profile!["birthday_day"].string, let month = profile!["birthday_month"].string, let year = profile!["birthday_year"].string {
                let dateStr = "\(year)/\(month)/\(day)"
//                self.birthdate = dateStr.toDate(withFormat: "y/M/d")
            }
        }
    }
    
    var localName: String? {
        if city != nil {
            return "\(city!.provinceName) ، \(city!.name)"
        } else if provinceName != nil && cityName == nil {
            return "\(provinceName!) ، \(cityName!)"
        }else {
            return nil
        }
    }
    
//    var isCompleted: Bool { return !self.name!.isEmpty }
    var isCompleted: Bool { return true }
    
    var parameter: [String: Any] {
        get {
            let param = [String: Any]()
            
            return param
        }
    }
    
}

enum Gender: String {
    case man = "male"
    case female = "female"
    
    var id: Int{
        switch self {
        case .man: return 0
        default: return 1
        }
    }
    
    init(id: Int){
        switch id {
        case 0: self = .man
        default: self = .female
        }
    }
    
}

