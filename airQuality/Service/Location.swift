//
//  Location.swift
//  airQuality
//
//  Created by Adrian Evensen on 31/01/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject {
    fileprivate var location: CLLocation?
    
    fileprivate let manager = CLLocationManager()

    /// Returns (Latitude, Longitude)
    func getCoordinates() -> (Double?, Double?) {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            location = manager.location
        }
        return (location?.coordinate.latitude, location?.coordinate.longitude)
    }
    
    var permissionHandler: ((Bool) -> ())?
    func askPermission(handler: @escaping (Bool) -> ()) {
        manager.delegate = self
        permissionHandler = handler
        manager.requestWhenInUseAuthorization()
    }
}

extension Location: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            permissionHandler?(true)
        }
    }
    
}
