////
////  HttpServiceClient.swift
////  ShahrYar
////
////  Created by Sina Rabiei on 5/5/20.
////  Copyright © 2020 Sina Rabiei. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//struct HttpServiceClient: ServiceClient {
//    
//    func problemTypesList(completion: @escaping (Result<ProblemTypesList, ServiceClientResponseStatus>) -> Void) {
//        
//        httpClientManeger.request(.problemTypesList) { (result) in
//            
//            switch result {
//            case .failure(let error):
//                return completion(.failure(error))
//            case .success(let data):
//                guard let jsonArray = data.array else { return completion(.failure(.unableToDecode)) }
//                let items = jsonArray.map { json -> ProblemType in return ProblemType(json) }
//                completion(.success(items))
//            }
//            
//        }
//        
//    }
//    
//    func updateProfile(_ info: Profile, completion: @escaping (Result<Profile, ServiceClientResponseStatus>) -> Void) {
//        completion(.success(Profile()))
//    }
//    
//    func provincesList(completion: @escaping (Result<ProvincesList, ServiceClientResponseStatus>) -> Void) {
//        
//        httpClientManeger.request(.provincesList) { (result) in
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let data):
//                guard let jsonArray = data.array else { return completion(.failure(.unableToDecode)) }
//                let provincesList = jsonArray.map { json -> Province in return Province(json) }
//                completion(.success(provincesList))
//            }
//        }
//        
//    }
//    
//    func verifyPhone(_ info: Verify, completion: @escaping (Result<Profile, ServiceClientResponseStatus>) -> Void) {
//        
//        httpClientManeger.request(.verifyPhone(info)) { result in
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let data):
//                let profile = Profile(data)
//                completion(.success(profile))
//            }
//        }
//        
//    }
//    
//    func registerPhone(_ mobile: String, completion: @escaping (Result<Register, ServiceClientResponseStatus>) -> Void) {
//        
//        httpClientManeger.request(.registry(mobile)) { result in
//            
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let data):
//                let register = Register(data)
//                completion(.success(register))
//            }
//            
//        }
//        
//    }
//    
//    func checkTokenValidity(completion: @escaping (Result<Profile, ServiceClientResponseStatus>) -> Void) {
//        
//        httpClientManeger.request(.checkTokenValidity) { result in
//            
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let data):
//                let profile = Profile(data)
//                completion(.success(profile))
//            }
//            
//        }
//        
//    }
//    
//    private var httpClientManeger: HttpClientManeger = HttpClientManeger()
//    
//}
//
