//
//  WeatherApiTests.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/18/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import XCTest
@testable import Sydney_Weather
import Contacts

class WeatherApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let testData = "https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207"
        XCTAssert(WeatherAPI.sydneyLocationString == testData, "! WeatherAPI.sydneyLocationString == \(testData)")
    }
    
    func testGetCurrentWeather() {
        let weatherExpectation : XCTestExpectation = expectation(description: "expectation description")
        
        WeatherAPI.getCurrentWeather(with: { (weathers: [Weather]?, error: Error?) in
            XCTAssertNil(error)
            XCTAssertNotNil(weathers?.first)
            XCTAssertNotNil(weathers?.first?.temperature)
            XCTAssertNotNil(weathers?.first?.windSpeed)
            XCTAssertNotNil(weathers?.first?.humidity)
            XCTAssertNotNil(weathers?.first?.summary)
            weatherExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testGetHourlyWeathers() {
        let weatherExpectation : XCTestExpectation = expectation(description: "expectation description")
        
        WeatherAPI.getHourlyWeathers(with: { (weathers: [Weather]?, error: Error?) in
            XCTAssertNil(error)
            XCTAssertNotNil(weathers?.first)
            XCTAssertNotNil(weathers?.first?.temperature)
            XCTAssertNotNil(weathers?.first?.windSpeed)
            XCTAssertNotNil(weathers?.first?.humidity)
            XCTAssertNotNil(weathers?.first?.summary)
            weatherExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
