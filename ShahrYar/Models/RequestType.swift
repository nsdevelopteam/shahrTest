//
//  RequestType.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ProblemTypesList = [ProblemType]

struct ProblemType {
    
    let id: Int
    let title: String
    let description: String?
    let published: Int
    let order: Int
    let pinImage: String
    let checkMarker: String
    let alarmSound: String
    let image: String
    
    init(_ json: JSON) {
        self.id = json["id"].int!
        self.title = json["title"].stringValue
        self.description = json["description"].string
        self.published = json["published"].int!
        self.order = json["order"].int!
        self.pinImage = json["pin_image"].string!
        self.checkMarker = json["check_marker"].string!
        self.alarmSound = json["alarm_sound"].string!
        self.image = json["image"].string!
    }
    
}
