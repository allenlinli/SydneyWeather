//
//  WeatherAPI.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

/*
 1. Dark Sky API format: https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE
 2. example format of Sydney: https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207
 3. Dark Sky API document: https://developer.forecast.io/docs/v2
 4. The AP keyI is: 9a678de7904f9c4c671ea43271da7acb
*/
class WeatherAPI
{
    static let sharedInstance = WeatherAPI()
    
    let ApiKey = "9a678de7904f9c4c671ea43271da7acb"
    
    enum TimingType : Int {
        case current = 0
        case hourly
    }
    
    let session : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    public func getCurrentWeather() -> (temperature: Float?, humidity: Float?, windspeed: Float?, summary: String?)?
    {
        return nil
    }
    
    public func getHourlyWeathers() -> [Weather]?
    {
        return nil
    }
}
