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
    
    
    
    func testRawWeatherURL() {
        let weatherExpectation = expectation(description: "SomeService does stuff and runs the callback closure")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: "https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207") else {
            XCTAssert(false, "Error: cannot create URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as?  [String: AnyObject]
                    XCTAssert(dic != nil, "! object != nil")
                    
                    guard let currentlyDic = dic?["currently"] as? [String:AnyObject] else {
                        XCTAssert(false, "! guard let currentlyDic = dic[\"currently\"]")
                        return
                    }
                    
                    guard let temperature = currentlyDic["temperature"] as? Float else {
                        XCTAssert(false, "guard let temperature = currentlyDic[\"temperature\"]")
                        return
                    }
                    print("temperature in Sydney: \(temperature)")
                    
                } catch let error as NSError {
                    XCTAssert(false, "! testRawWeatherAPI, error: \(error)")
                }
                weatherExpectation.fulfill()
            }
        }
        
        task.resume()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
