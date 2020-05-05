//
//  HttpRequest.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import Alamofire

protocol HttpRequestProtocol {
    var encoding: ParameterEncoding {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: [String: Any]? {get}
    var headers: [String: String]? {get}
}

enum URLs: String{
    case backend = "http://moshkelateshahri.xyz/api"
    case image = "http://moshkelateshahri.xyz/"
}

enum HttpRequest: HttpRequestProtocol {
    
    case checkTokenValidity
    case registry(_ mobile: String)
    case verifyPhone(_ info: Verify)
    case provincesList
    case updateProfile(_ info: Profile)
    case problemTypesList
    
    private var environment: String {
        return URLs.backend.rawValue
    }
    
    var path: String {
        get {
            switch self {
            case .provincesList:
                return "\(environment)/provinces"
            case .checkTokenValidity:
                return "\(environment)/login"
            case .registry:
                return "\(environment)/verify"
            case .verifyPhone:
                return "\(environment)/register"
            case .updateProfile:
                return "\(environment)/setProfile"
            case .problemTypesList:
                return "\(environment)/request-types"
            }
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkTokenValidity, .provincesList, .problemTypesList:
            return .get
        case .registry, .verifyPhone, .updateProfile:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .verifyPhone(let info):
            return info.parameter
        case .checkTokenValidity:
            return ["api_token": HttpRequest.token ?? ""]
        case .registry(mobile: let mobile):
            return ["mobile": mobile]
        case .updateProfile(let profile):
            return profile.parameter
        default:
            return [:]
        }
        
    }
    
    static var token: String? {
        get { return UserDefaults.standard.value(forKey: UserDefaultsKey.token.rawValue) as? String }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.token.rawValue) }
    }
    
    var headers: [String : String]? {
        if let token = HttpRequest.token { return ["Token": token] }
        return nil
    }
    
    var encoding: ParameterEncoding {
        switch  self {
        default:
            return URLEncoding.default
        }
    }
    
}


