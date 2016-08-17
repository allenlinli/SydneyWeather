//
//  Sydney_WeatherRawUrlTests.swift
//  Sydney WeatherTests
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import XCTest
@testable import Sydney_Weather
import Contacts

class Sydney_WeatherRawUrlTests: XCTestCase {
    let session : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    let urlString = "https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207"
    
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
    
    func testUrl() {
        let url = URL(string: urlString)
        XCTAssert(url != nil, "! url != nil")
    }
    
    func testRawCurrentWeatherURL() {
        let weatherExpectation : XCTestExpectation = expectation(description: "expectation description")
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            XCTAssert(data != nil, "! data != nil")
            
            do {
                let dic = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: AnyObject]
                XCTAssert(dic != nil, "! object != nil")
                
                // MARK: test current weather data
                guard let currentlyDic = dic?["currently"] as? [String:AnyObject] else {
                    XCTAssert(false, "! guard let currentlyDic = dic[\"currently\"]")
                    return
                }
                
                guard let temperature = currentlyDic["temperature"] as? Float else {
                    XCTAssert(false, "! guard let temperature = currentlyDic[\"temperature\"]")
                    return
                }
                print("temperature in Sydney: \(temperature)")
                
                guard let summary = currentlyDic["summary"] as? String else {
                    XCTAssert(false, "! guard let summary = currentlyDic[\"summary\"]")
                    return
                }
                print("summary in Sydney: \(summary)")
                
                guard let humidity = currentlyDic["humidity"] as? Float else {
                    XCTAssert(false, "! guard let humidity = currentlyDic[\"humidity\"]")
                    return
                }
                print("humidity in Sydney: \(humidity)")
                
                guard let windSpeed = currentlyDic["windSpeed"] as? Float else {
                    XCTAssert(false, "! guard let windSpeed = currentlyDic[\"windSpeed\"]")
                    return
                }
                print("windSpeed in Sydney: \(windSpeed)")
            } catch let error as NSError {
                XCTAssert(false, "! testRawWeatherAPI, error: \(error)")
            }
            weatherExpectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testRawHourlyWeatherURL() {
        let weatherExpectation : XCTestExpectation = expectation(description: "expectation description")
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            XCTAssert(data != nil, "! data != nil")
            
            do {
                let dic = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: AnyObject]
                XCTAssert(dic != nil, "! object != nil")
                
                // MARK: test current weather data
                guard let hourlyDic = dic?["hourly"] as? [String:AnyObject] else {
                    XCTAssert(false, "! guard let hourlyDic = dic[\"hourlyDic\"]")
                    return
                }
                
                guard let data = hourlyDic["data"] as? [AnyObject] else {
                    XCTAssert(false, "! guard let data = currentlyDic[\"data\"]")
                    return
                }
                
                XCTAssert(data.count != 0, "! data.count != 0")
                
                guard let firstWeather = data.first as? [String : AnyObject] else {
                    XCTAssert(false, "! guard let firstWeather = data.first as? [String : AnyObject]")
                    return
                }
                
                guard let temperature = firstWeather["temperature"] else {
                    XCTAssert(false, "! guard let temperature = currentlyDic[\"temperature\"]")
                    return
                }
                print("hourly temperature in Sydney: \(temperature)")
                
                guard let summary = firstWeather["summary"] else {
                    XCTAssert(false, "! guard let summary = currentlyDic[\"summary\"]")
                    return
                }
                print("hourly summary in Sydney: \(summary)")
                
                guard let humidity = firstWeather["humidity"] as? Float else {
                    XCTAssert(false, "! guard let humidity = currentlyDic[\"humidity\"]")
                    return
                }
                print("hourly humidity in Sydney: \(humidity)")
                
                guard let windSpeed = firstWeather["windSpeed"] as? Float else {
                    XCTAssert(false, "! guard let windSpeed = currentlyDic[\"windSpeed\"]")
                    return
                }
                print("hourly windSpeed in Sydney: \(windSpeed)")
            } catch let error as NSError {
                XCTAssert(false, "! testRawWeatherAPI, error: \(error)")
            }
            
            weatherExpectation.fulfill()
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
