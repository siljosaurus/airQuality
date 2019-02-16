//
//  File.swift
//  airQuality
//
//  Created by Adrian Evensen on 16/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation


struct Station {
    var measures: [Measure]?
    var latitude: Double?
    var longitude: Double?
    
    var name: String?
    var area: String?
    
    init(measures: [Measure]) {
        self.measures = measures
        for i in 0..<measures.count {
            if let lat = measures[i].latitude,
                let long = measures[i].longitude,
                let name = measures[i].station,
                let area = measures[i].area {
                self.latitude = lat
                self.longitude = long
                self.name = name
                self.area = area
                break
            }
        }
    }
    
    func getHealthRisk() -> HealthRisk? {
        var worst = 0
        measures?.forEach({ (measure) in
            let risk = measure.calculateHealthRisk()
            if risk.rawValue > worst {
                worst = risk.rawValue
            }
        })
        return HealthRisk(rawValue: worst)
    }
    
}
