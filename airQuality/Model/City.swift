//
//  City.swift
//  airQuality
//
//  Created by Adrian Evensen on 03/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import Foundation

enum HealthRisk: Int {
    case low = 1, moderate, high, veryHigh
}

class City {
    fileprivate var measures: [Measure]
    
    var healthRisk: HealthRisk = .low
    
    init(measures: [Measure]) {
        self.measures = measures
    }
        
    /**
     Samlede forurensnings angis for det stoffet med den høyeste klassen.
     
     Basert på data fra https://luftkvalitet.miljostatus.no/artikkel/613
     
     Bruker timesverdi (PM10, PM2.5) med begrunnelse:
     https://cmsapi-luft.miljodirektoratet.no/globalassets/dokumenter/luftkvalitet/timesmiddel_pm_forurensningsklasser.pdf
     Tenker dette er pga lite svevestøv om natten som drar ned snittet (for døgnet).
     */
    func calculateHealthRisk() -> HealthRisk {
        var worstCase: HealthRisk = .low
        
        measures.forEach { (measure) in
            var currentCase: HealthRisk = .low
            guard let value = measure.value else { return }
            switch measure.component {
            case "PM10":
                if value < 60 {
                    currentCase = .low
                } else if value < 120 {
                    currentCase = .moderate
                } else if value < 400 {
                    currentCase = .high
                } else if value > 400 {
                    currentCase = .veryHigh
                }
                break
                
            case "PM2.5":
                if value < 30 {
                    currentCase = .low
                } else if value < 50 {
                    currentCase = .moderate
                } else if value < 150 {
                    currentCase = .high
                } else if value > 150 {
                    currentCase = .veryHigh
                }
                break
                
            case "NO2":
                if value < 100 {
                    currentCase = .low
                } else if value < 200 {
                    currentCase = .moderate
                } else if value < 400 {
                    currentCase = .high
                } else if value > 400 {
                    currentCase = .veryHigh
                }
                break

            case "O3":
                if value < 100 {
                    currentCase = .low
                } else if value < 180 {
                    currentCase = .moderate
                } else if value < 240 {
                    currentCase = .high
                } else if value > 240 {
                    currentCase = .veryHigh
                }
                break
            default: break
            }
            
            if currentCase.rawValue > worstCase.rawValue {
                worstCase = currentCase
            }
        }
        
        self.healthRisk = worstCase
        return worstCase
    }
    
    
}
