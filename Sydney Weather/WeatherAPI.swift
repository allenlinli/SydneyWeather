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

public class WeatherAPI
{
    static let sharedInstance = WeatherAPI()
    
    static let ApiKey = "9a678de7904f9c4c671ea43271da7acb"
    static let TemplateURL: String = "https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE"
 
    
    // TODO: Not sure which one is better?
    // 1. (temperature: Temperature?,  windSpeed: WindSpeed?, humidity: Humidity?, summary: Summary?) -> Void
    // 2. Weather
    public typealias CompletionHandler = (weather: Weather?) -> Void
    
    enum TimingType : Int {
        case current = 0
        case hourly
    }
    
    static let session : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    static var sydneyLocationString: String
    {
        get {
            let sydneyLocationString = TemplateURL.replacingOccurrences(of: "APIKEY", with: ApiKey).replacingOccurrences(of: "LATITUDE", with: String(Constants.SydneyLocation.latitude)).replacingOccurrences(of: "LONGITUDE", with: String(Constants.SydneyLocation.longitude))
            assert(sydneyLocationString == "https://api.forecast.io/forecast/9a678de7904f9c4c671ea43271da7acb/-33.8675,151.207")
            return sydneyLocationString
        }
    }
    
    // TODO: can use try catch in the future. 
    // And use code error to decide if I clean UI or not
    public static func getCurrentWeather(with completionHandler: CompletionHandler)
    {
        let url = URL(string: sydneyLocationString)
        let request = URLRequest(url: url!)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            assert(error == nil, "! error == nil, error: \(error)")
            if error != nil
            {
                // use closure to clear UI
                completionHandler(weather: nil)
                assertionFailure("! error != nil: \(error)")
                return
            }
            
            do
            {
                let dic = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: AnyObject]
                assert(dic != nil, "! object != nil")
                
                let currentlyDic = dic?["currently"] as? [String:AnyObject]
                let temperature = currentlyDic?["temperature"] as? Temperature
                let summary = currentlyDic?["summary"] as? Summary
                let humidity = currentlyDic?["humidity"] as? Humidity
                let windSpeed = currentlyDic?["windSpeed"] as? WindSpeed
                
                let weather = Weather(temperature: temperature, humidity: humidity, windSpeed: windSpeed, summary: summary)
                
                completionHandler(weather: weather)
            }
            catch let error as NSError
            {
                completionHandler(weather: nil)
                assertionFailure("! error in let dic = try JSONSerialization.jsonObject:\(error)")
            }
            
        }
        
        task.resume()
    }
    
    public func getHourlyWeathers() -> [Weather]?
    {
        return nil
    }
}
