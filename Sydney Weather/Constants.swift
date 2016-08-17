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
    struct SydneyLocation
    {
        static let latitude: Double = -33.8675
        static let longitude: Double = 151.207
        
        static func coordinate2D() -> CLLocationCoordinate2D
        {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        //???
        /*
        var coordinate2D: CLLocationCoordinate2D
        {
            get {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
         */
    }
}
