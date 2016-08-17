//
//  Constants.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import CoreLocation

struct Constants
{
    // Sydney GPS: lat -33.8675; long 151.207;
    struct SydneyLocation
    {
        static let latitude: Double = -33.8675
        static let longitude: Double = 151.207
        
        static func coordinate2D() -> CLLocationCoordinate2D
        {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    let ApiKey = "9a678de7904f9c4c671ea43271da7acb"
    
    /* value we need
    ● Temperature ● Humidity
    ● Windspeed ● Summary
    */
    enum WeatherDataType: String {
        case Temperature = "Temperature"
        case Humidity = "Humidity"
        case Windspeed = "Windspeed"
        case Summary = "Summary"
    }
}
