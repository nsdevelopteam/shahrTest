////
////  HttpClientManeger.swift
////  ShahrYar
////
////  Created by Sina Rabiei on 5/5/20.
////  Copyright © 2020 Sina Rabiei. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//import Alamofire
//
//struct HttpClientManeger {
//    
//    func request(_ request: HttpRequest, completion: @escaping (HttpClientResult<JSON, ServiceClientResponseStatus>) -> Void) {
//        
//        guard URL(string: request.path) != nil else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//        
//        AF.request(request.path, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).responseJSON { (response) in
//            
//            let status = self.serviceClient(response)
//            
//            switch status {
//            case .success:
//                let json = try! JSON(data: response.data!)
//                completion(.success(json))
//            default:
//                completion(.failure(status))
//            }
//            
//        }
//        
//    }
//    
//    private func serviceClient(_ response: DataResponse<Any, Error>)-> ServiceClientResponseStatus {
//        
//        let status = ServiceClientResponseStatus(statusCode: response.response?.statusCode)
//        
//        switch status {
//        case .success:
//            guard let data = response.data else { return .noData }
//            guard let json = try? JSON(data: data) else { return .unableToDecode }
//            debugPrint(json)
//            return status
//            
//        case  .clientError(let info):
//            guard let data = response.data else { return .noData }
//            guard let json = try? JSON(data: data) else { return .unableToDecode }
//            debugPrint(json)
//            let error = json["error"].stringValue
//            return .clientError(code: info.code, message: error)
//            
//        default: return status
//        }
//        
//    }
//    
//    
//}
//
//
//
