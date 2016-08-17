//
//  Constants.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import CoreLocation

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
}
