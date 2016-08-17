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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testData = "https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207"
        XCTAssert(WeatherAPI.sydneyLocationString == testData, "! WeatherAPI.sydneyLocationString == \(testData)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
