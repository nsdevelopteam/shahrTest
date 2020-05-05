//
//  Verify.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation

struct Verify {
    
    private(set) var mobile: String
    private(set) var code: Int
    
    init(_ mobile: String, code: Int) {
        self.mobile = mobile
        self.code = code
    }
    
    
    var parameter: [String: Any] {
        get  {
            var parameter = [String: Any]()
            parameter["mobile"] = self.mobile
            parameter["code"] = self.code
            return parameter
        }
    }
}
