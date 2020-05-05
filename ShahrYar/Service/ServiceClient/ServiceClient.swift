////
////  ServiceClient.swift
////  ShahrYar
////
////  Created by Sina Rabiei on 5/5/20.
////  Copyright © 2020 Sina Rabiei. All rights reserved.
////
//
//import Foundation
//
//protocol ServiceClient {
//    func checkTokenValidity(completion: @escaping (Result<Profile, ServiceClientResponseStatus>)-> Void)
//    func registerPhone(_ mobile: String, completion: @escaping (Result<Register, ServiceClientResponseStatus>)-> Void)
//    func verifyPhone(_ info: Verify, completion: @escaping (Result<Profile, ServiceClientResponseStatus>)-> Void)
//    func provincesList(completion: @escaping (Result<ProvincesList, ServiceClientResponseStatus>)-> Void)
//    func updateProfile(_ info: Profile, completion: @escaping (Result<Profile, ServiceClientResponseStatus>)-> Void)
//    func problemTypesList(completion: @escaping (Result<ProblemTypesList, ServiceClientResponseStatus>)-> Void)
//}
