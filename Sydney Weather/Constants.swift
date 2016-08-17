//
//  Constants.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import CoreLocation

public typealias Temperature = Float
public typealias WindSpeed = Float
public typealias Humidity = Float
public typealias Summary = String

public typealias DicType = [String: AnyObject]

public struct Constants
{
    // Sydney GPS: lat -33.8675; long 151.207;
    public struct SydneyLocation
    {
        public static let latitude: Double = -33.8675
        public static let longitude: Double = 151.207
        
        public static func coordinate2D() -> CLLocationCoordinate2D
        {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    public struct WeatherAPIKey
    {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let windSpeed = "windSpeed"
        static let summary = "summary"
        static let time = "time"
        static let currently = "currently"
        static let data = "data"
        static let hourly = "hourly"
    }
}
