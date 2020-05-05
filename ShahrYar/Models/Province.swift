//
//  Province.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ProvincesList = [Province]

struct Province {
    
    private(set) var id: Int
    private(set) var name: String
    private(set) var citiesList = CitiesList()
    
    var isExpanded: Bool =  false
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.citiesList = self.parseCitiesList(from: json)
    }
    
    private func parseCitiesList(from json: JSON)-> CitiesList {
        guard let jsonArray = json["cities"].array else { return [] }
        let citiesList = jsonArray.map { jsonCity -> City in return City(jsonCity, provinceName: self.name) }
        return citiesList
    }
    
}
