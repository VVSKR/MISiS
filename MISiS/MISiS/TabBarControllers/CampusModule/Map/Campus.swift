//
//  Campus.swift
//  MISiS
//
//  Created by Vova SKR on 11.02.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation
import MapKit

enum CampusData {
    static public var campus =
        ["Корпус А": CLLocationCoordinate2D(latitude: 55.72762134, longitude: 37.60798442), //
         "Корпус Б": CLLocationCoordinate2D(latitude: 55.72809977, longitude: 37.60879512), //
         "Корпус В": CLLocationCoordinate2D(latitude: 55.728087, longitude: 37.60721773), //
         "Корпус Г": CLLocationCoordinate2D(latitude: 55.72731618, longitude: 37.6069147), //
         "Корпус Д": CLLocationCoordinate2D(latitude: 55.72760133, longitude: 37.60626089),
         "Корпус Л": CLLocationCoordinate2D(latitude: 55.72774243, longitude: 37.60592729), //
            "Корпус К": CLLocationCoordinate2D(latitude: 55.72981547, longitude: 37.61011451) //
    ]
    
    
    static public var adress = [
        "Корпус А": "Ленинский проспект, 6с2", //
        "Корпус Б": "Ленинский проспект, 4", //
        "Корпус В": "Ленинский проспект, 6с7", //
        "Корпус Г":"Ленинский проспект, 6", //
        "Корпус Д": "Ленинский проспект, 6с21", //
        "Корпус Л": "Ленинский проспект, 6с7", //
        "Корпус К": "улица Крымский вал, 3", //
        
        ]
}
