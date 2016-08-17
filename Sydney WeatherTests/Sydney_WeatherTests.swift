//
//  Sydney_WeatherTests.swift
//  Sydney WeatherTests
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import XCTest
@testable import Sydney_Weather
import Contacts

class Sydney_WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstants() {
        
        let SydneyLocationLatitude = -33.8675
        let SydneyLocationLongitude = 151.207
        //XCTAssert(Constants.SydneyLocation.init().latitude == -33.8675)
        //XCTAssert(Constants.SydneyLocation.init().longitude == 151.207)
        XCTAssert(Constants.SydneyLocation.latitude == SydneyLocationLatitude)
        XCTAssert(Constants.SydneyLocation.longitude == SydneyLocationLongitude)
        XCTAssert(Constants.SydneyLocation.coordinate2D().latitude == SydneyLocationLatitude)
        XCTAssert(Constants.SydneyLocation.coordinate2D().longitude == SydneyLocationLongitude)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
