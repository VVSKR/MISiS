//
//  UserLocation.swift
//  MISiS
//
//  Created by Vova SKR on 31.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import MapKit
import UIKit

class UserLocation: CLLocationManager, CLLocationManagerDelegate {

    var isEnabled = false {
        willSet {
            newValue == true ? self.startUpdatingLocation() : self.stopUpdatingLocation()
        }
    }

    var userCoordinate: CLLocationCoordinate2D {
        return self.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.754539, longitude: 37.707774)
    }

    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            self.delegate = self
            self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        }
    }

}
