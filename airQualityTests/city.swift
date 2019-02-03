//
//  airQualityTests.swift
//  airQualityTests
//
//  Created by Adrian Evensen on 03/02/2019.
//  Copyright © 2019 Silje Marie Flaaten. All rights reserved.
//

import XCTest
@testable import airQuality

class airQualityTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCityMultipleLow() {
        let measures = [
            getMeasure(component: "PM2.5", value: 20),
            getMeasure(component: "PM10", value: 50),
            getMeasure(component: "O3", value: 90)
        ]
        let city = City(measures: measures)
        
        XCTAssertEqual(city.calculateHealthRisk(), .low)
    }
    
    func testCityMultipleHigh() {
        let measures = [
            getMeasure(component: "PM10", value: 300),
            getMeasure(component: "PM2.5", value: 140),
            getMeasure(component: "O3", value: 90)
        ]
        let city = City(measures: measures)
        
        XCTAssertEqual(city.calculateHealthRisk(), .high)
    }
    
    
    func testCitySinglePM2() {
        let cityLow = City(measures: [getMeasure(component: "PM2.5", value: 20)])
        let cityModerate = City(measures: [getMeasure(component: "PM2.5", value: 40)])
        let cityHigh = City(measures: [getMeasure(component: "PM2.5", value: 140)])
        let cityVeryHigh = City(measures: [getMeasure(component: "PM2.5", value: 160)])
        
        XCTAssertEqual(cityLow.calculateHealthRisk(), .low)
        XCTAssertEqual(cityModerate.calculateHealthRisk(), .moderate)
        XCTAssertEqual(cityHigh.calculateHealthRisk(), .high)
        XCTAssertEqual(cityVeryHigh.calculateHealthRisk(), .veryHigh)
    }
    
    func testCitySinglePM10() {
        let cityLow = City(measures: [getMeasure(component: "PM10", value: 50)])
        let cityModerate = City(measures: [getMeasure(component: "PM10", value: 110)])
        let cityHigh = City(measures: [getMeasure(component: "PM10", value: 390)])
        let cityVeryHigh = City(measures: [getMeasure(component: "PM10", value: 410)])
        
        XCTAssertEqual(cityLow.calculateHealthRisk(), .low)
        XCTAssertEqual(cityModerate.calculateHealthRisk(), .moderate)
        XCTAssertEqual(cityHigh.calculateHealthRisk(), .high)
        XCTAssertEqual(cityVeryHigh.calculateHealthRisk(), .veryHigh)
    }
    
    func testCitySingleO3() {
        let cityLow = City(measures: [getMeasure(component: "O3", value: 90)])
        let cityModerate = City(measures: [getMeasure(component: "O3", value: 170)])
        let cityHigh = City(measures: [getMeasure(component: "O3", value: 230)])
        let cityVeryHigh = City(measures: [getMeasure(component: "O3", value: 260)])
        
        XCTAssertEqual(cityLow.calculateHealthRisk(), .low)
        XCTAssertEqual(cityModerate.calculateHealthRisk(), .moderate)
        XCTAssertEqual(cityHigh.calculateHealthRisk(), .high)
        XCTAssertEqual(cityVeryHigh.calculateHealthRisk(), .veryHigh)
    }
    
    func getMeasure(component: String, value: Double) -> Measure {
        return Measure(zone: nil, municipality: nil, area: nil, station: nil, component: component, fromTime: nil, toTime: nil, value: value, unit: nil, latitude: nil, longitude: nil, timestep: nil, index: nil, color: nil)
    }

}
