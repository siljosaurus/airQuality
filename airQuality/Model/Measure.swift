//
//  Measure.swift
//  airQuality
//
//  Created by Adrian Evensen on 01/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation

struct Measure: Decodable {
    var zone: String?
    var municipality: String?
    var area: String?
    var station: String?
    var component: String?
    var fromTime: String?
    var toTime: String?
    var value: Double?
    var unit: String?
    var latitude: Double?
    var longitude: Double?
    var timestep: Int?
    var index: Int?
    var color: String?
}
