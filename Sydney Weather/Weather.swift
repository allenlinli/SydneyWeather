//
//  Weather.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

struct Weather
{
    var temperature: Float?
    var humidity: Float?
    var windspeed: Float?
    var summary: String?
    
    let weatherType: Constants.WeatherType
    
    init(weatherType: Constants.WeatherType) {
        self.weatherType = weatherType
    }
    
    init(weatherType: Constants.WeatherType, temperature: Float?, humidity: Float?, windspeed: Float?, summary: String?) {
        self.weatherType = weatherType
        self.temperature = temperature
        self.humidity = humidity
        self.windspeed = windspeed
        self.summary = summary
    }
}
