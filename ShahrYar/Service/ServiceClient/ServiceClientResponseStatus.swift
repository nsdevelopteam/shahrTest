//
//  ServiceClientResponseStatus.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation

public enum ServiceClientResponseStatus: Error {
    
    //HTTP Status
    case informational(code: Int) // 100...199
    case success(code: Int) // 200...299
    case redirection(code: Int) //300...399
    case clientError(code: Int, message: String?) //400...499
    case serverError(code: Int, message: String?) //500...599
    
    //Other
    case unknown(message: String?)
    case invalidUrl
    case failed(message: String?)
    case noData
    case unableToDecode
    
    //Internal Status
    case succeeded(message: String?)
    case unsuccessful(message: String?)
    
    var isFailed: Bool {
        switch self {
        case .failed, .invalidUrl, .noData, .unableToDecode, .unknown:
            return true
        default:
            return false
        }
    }
    var isSuccess: Bool {
        get {
            switch self {
            case .success, .informational, .succeeded:
                return true
            default:
                return false
            }
        }
    }
    var description: String{
        switch self {
        case .clientError(let info):
            return "\(info.message ?? "Description")"
        default:
            return "Description"
        }
    }
    
    init(statusCode: Int?) {
        
        guard let statusCode = statusCode else {
            self = .failed(message: "Can't Connect To The Internet")
            return
        }
        
        switch statusCode {
        case 100...199: self = .informational(code: statusCode)
        case 200...299: self = .success(code: statusCode)
        case 300...399: self = .redirection(code: statusCode)
        case 400...500: self = .clientError(code: statusCode, message: nil)
        case 500...599: self = .serverError(code: statusCode, message: nil)
        default: self = .failed(message: "Can't Connect To The Internet")
        }
        
        /// https://www.restapitutorial.com/httpstatuscodes.html
        ///    1xx (Informational): The request was received, continuing process
        ///    2xx (Successful): The request was successfully received, understood, and accepted
        ///    3xx (Redirection): Further action needs to be taken in order to complete the request
        ///    4xx (Client Error): The request contains bad syntax or cannot be fulfilled
        ///    5xx (Server Error): The server failed to fulfill an apparently valid request
        
    }
    
}

