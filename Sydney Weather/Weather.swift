//
//  Weather.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

// TODO: not sure it's good to put typealias here. Because WeatherAPI will depend on this.

public struct Weather
{
    public var temperature: Temperature?
    public var humidity: Humidity?
    public var windSpeed: WindSpeed?
    public var summary: Summary?
    public var date: Date?
    
    // TODO: can consider decoupling by making a new static public function in Weather called "getWeather(with dictionary: DicType) -> Weather" 
    init(with dictionary: [String: AnyObject]) {
        self.temperature = dictionary[Constants.WeatherAPIKey.temperature] as? Temperature
        self.summary = dictionary[Constants.WeatherAPIKey.summary] as? Summary
        self.humidity = dictionary[Constants.WeatherAPIKey.humidity] as? Humidity
        self.windSpeed = dictionary[Constants.WeatherAPIKey.windSpeed] as? WindSpeed
        let unixTime = dictionary[Constants.WeatherAPIKey.time] as? TimeInterval
        
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
