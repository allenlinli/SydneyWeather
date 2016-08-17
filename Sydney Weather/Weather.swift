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
    var humidity: WindSpeed?
    var windSpeed: Humidity?
    var summary: Summary?
    var date: Date?
}
