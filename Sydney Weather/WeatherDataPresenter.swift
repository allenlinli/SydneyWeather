//
//  WeatherDataPresenter.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/18/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

struct WeatherDataPresenter
{
    var weather: Weather
    
    var summary: String? {
        get {
            return weather.summary
        }
    }
    
    var temperature: String? {
        get {
            if let temperature = weather.temperature {
                let cTemperature = Constants.celsius(wtih: temperature)
                return NSString(format:"%.0f", cTemperature).appending("°c")
            }
            else {
                return nil
            }
        }
    }
    
    var humidity: String? {
        get {
            if let humidity = weather.humidity {
                return NSString(format:"%.0f", humidity*100).appending("°%")
            }
            else {
                return nil
            }
        }
    }
    
    var windSpeed: String? {
        get {
            if let windSpeed = weather.windSpeed {
                return NSString(format:"%.0f", windSpeed).appending(" km/h")
            }
            else {
                return nil
            }
        }
    }
    
    var time: String? {
        get {
            if let date = weather.date {
                let formatter = DateFormatter()
                formatter.dateFormat = "H:mm"
                formatter.string(from: date)
                let timeString = formatter.string(from: date)
                return timeString
            }
            else {
                return nil
            }
        }
    }
}
