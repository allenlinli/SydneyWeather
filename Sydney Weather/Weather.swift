//
//  Weather.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

// TODO: not sure it's good to put typealias here. Because WeatherAPI will depend on this.
public typealias Temperature = Float
public typealias WindSpeed = Float
public typealias Humidity = Float
public typealias Summary = String

public struct Weather
{
    var temperature: Temperature?
    var humidity: Humidity?
    var windSpeed: WindSpeed?
    var summary: Summary?
    var date: Date?
    
    init(with dictionary: [String: AnyObject]) {
        self.temperature = dictionary[WeatherAPI.Key.temperature.rawValue] as? Temperature
        self.summary = dictionary[WeatherAPI.Key.summary.rawValue] as? Summary
        self.humidity = dictionary[WeatherAPI.Key.humidity.rawValue] as? Humidity
        self.windSpeed = dictionary[WeatherAPI.Key.windSpeed.rawValue] as? WindSpeed
        let unixTime = dictionary[WeatherAPI.Key.time.rawValue] as? TimeInterval
        
        assert(unixTime != nil, "! unixTime")
        
        if let unixTime = unixTime
        {
            self.date = Date(timeIntervalSince1970: unixTime)
        }
    }
    
    init(temperature: Temperature?, humidity: Humidity?, windSpeed: WindSpeed?, summary: Summary?, date: Date?) {
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.summary = summary
        self.date = date
    }
}
