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
    
    // API format: https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE
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
    
    /*
     Test the following values in current weather
     ● Temperature ● Humidity
     ● Windspeed ● Summary
 */
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
                let currentlyDic = dic?["currently"] as? [String:AnyObject]
                XCTAssert(currentlyDic != nil, "! guard let currentlyDic = dic[\"currently\"]")
                
                let temperature = currentlyDic?["temperature"] as? Float
                XCTAssert(temperature != nil, "! guard let temperature = dic[\"temperature\"]")
                
                let summary = currentlyDic?["summary"] as? String
                XCTAssert(summary != nil, "! guard let summary = dic[\"summary\"]")
                
                let humidity = currentlyDic?["humidity"] as? Float
                XCTAssert(humidity != nil, "! guard let humidity = dic[\"humidity\"]")
                
                let windSpeed = currentlyDic?["windSpeed"] as? Float
                XCTAssert(windSpeed != nil, "! guard let windSpeed = dic[\"windSpeed\"]")
                
            } catch let error as NSError {
                XCTFail("! testRawWeatherAPI, error: \(error)")
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
    
    /*
     Test the following values in hourly weather
     ● Time
     ● Temperature ● Humidity
     ● Windspeed ● Summary
     */
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
                let hourlyDic = dic?["hourly"] as? [String:AnyObject]
                XCTAssert(hourlyDic != nil, "! let hourlyDic = dic[\"hourly\"]")
                
                let data = hourlyDic?["data"] as? [AnyObject]
                XCTAssert(data != nil, "! let data = hourlyDic[\"data\"]")
                
                let firstWeather = data?.first as? [String : AnyObject]
                XCTAssert(data != nil, "! let firstWeather = data.first")
                
                let temperature = firstWeather?["temperature"] as? Float
                XCTAssert(temperature != nil, "! hourly guard let temperature = dic[\"temperature\"]")
                
                let summary = firstWeather?["summary"] as? String
                XCTAssert(summary != nil, "! hourly guard let summary = dic[\"summary\"]")
                
                let humidity = firstWeather?["humidity"] as? Float
                XCTAssert(humidity != nil, "! hourly guard let humidity = dic[\"humidity\"]")
                
                let windSpeed = firstWeather?["windSpeed"] as? Float
                XCTAssert(windSpeed != nil, "! hourly guard let windSpeed = dic[\"windSpeed\"]")
                
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
