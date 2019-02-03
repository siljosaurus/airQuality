//
//  City.swift
//  airQuality
//
//  Created by Adrian Evensen on 03/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation


class City {
    var measures: [Measure]
    
    var healthRisk: HealthRisk = .low
    var area: String?
    var station: String?
    
    init(measures: [Measure]) {
        self.measures = measures
        self.area = measures.first?.area
        self.station = measures.first?.getStation()
    }

    func calculateHealthRisk() -> HealthRisk {
        var worstCase: HealthRisk = .low
        measures.forEach { (measure) in
            let currentCase = measure.calculateHealthRisk()
            if currentCase.rawValue > worstCase.rawValue {
                worstCase = currentCase
            }
        }
        self.healthRisk = worstCase
        return worstCase
    }
}
