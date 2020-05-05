//
//  City.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias CitiesList = [City]

struct City {
    
    private(set) var id: Int
    private(set) var name: String
    private(set) var provinceId: Int
    private(set) var provinceName: String
    
    init(_ json: JSON, provinceName: String) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.provinceId = json["province_id"].intValue
        self.provinceName = provinceName
    }
    
}
