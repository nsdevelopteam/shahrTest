//
//  Register.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Register {
    
    private(set) var mobile: String
    private(set) var time: Int
    
    init(_ json: JSON) {
        self.mobile = json["mobile"].stringValue
        self.time = Int(json["time"].stringValue)!
    }
    
}
