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
    static let url: URL = URL(string: sydneyLocationString)!
    static let request = URLRequest(url: url)
    
    private typealias DicType = [String: AnyObject]
    private enum `Type`: String
    {
        case temperature = "temperature"
        case humidity = "humidity"
        case windSpeed = "windSpeed"
        case summary = "summary"
        case time = "time"
        case currently = "currently"
        case data = "data"
    }
    
    // TODO: Not sure which one is better?
    // 1. (temperature: Temperature?,  windSpeed: WindSpeed?, humidity: Humidity?, summary: Summary?) -> Void
    // 2. Weather
    // TODO: Make CompletionHandler = (with weathers: [Weather]?)
    public typealias CompletionHandler = (weathers: [Weather]?) -> Void
    
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
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            if error != nil
            {
                // use closure to clear UI
                completionHandler(weathers: nil)
                assertionFailure("! error != nil: \(error)")
                return
            }
            
            do
            {
                let dic = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: AnyObject]
                assert(dic != nil, "! dic != nil")
                
                if let weatherDic = dic?[Type.currently.rawValue] as? DicType
                {
                    if let weather = weather(with: weatherDic)
                    {
                        completionHandler(weathers: [weather])
                    }
                    else
                    {
                        assertionFailure("! if let weather = weather(with: weatherDic)")
                    }
                }
                else
                {
                    assertionFailure("! if let weatherDic = weatherDic as? DicType")
                }
            }
            catch let error as NSError
            {
                completionHandler(weathers: nil)
                assertionFailure("! error in let dic = try JSONSerialization.jsonObject:\(error)")
            }
        }
        
        task.resume()
    }
    
    public static func getHourlyWeathers(with completionHandler: CompletionHandler)
    {
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response, error) -> Void in
            if error != nil
            {
                // use closure to clear UI
                completionHandler(weathers: nil)
                assertionFailure("! error != nil: \(error)")
                return
            }
            
            do {
                let dic = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: AnyObject]
                assert(dic != nil, "! dic != nil")
                
                let hourlyDic = dic?["hourly"] as? DicType
                let data = hourlyDic?["data"] as? [AnyObject]
                
                var weathers: [Weather] = []
                data?.forEach({ (weatherDic: AnyObject) in
                    if let weatherDic = weatherDic as? DicType
                    {
                        if let weather = weather(with: weatherDic)
                        {
                            weathers.append(weather)
                        }
                        else
                        {
                            assertionFailure("! if let weather = weather(with: weatherDic)")
                        }
                    }
                    else
                    {
                        assertionFailure("! if let weatherDic = weatherDic as? DicType")
                    }
                })
                
                completionHandler(weathers: weathers)
            } catch let error as NSError {
                assertionFailure("error: \(error)")
                completionHandler(weathers: nil)
            }
        }
        
        task.resume()
    }
    
    private static func weather(with dictionary: DicType) -> Weather?
    {
        let temperature = dictionary[Type.temperature.rawValue] as? Temperature
        let summary = dictionary[Type.summary.rawValue] as? Summary
        let humidity = dictionary[Type.humidity.rawValue] as? Humidity
        let windSpeed = dictionary[Type.windSpeed.rawValue] as? WindSpeed
        let unixTime = dictionary[Type.time.rawValue] as? TimeInterval
        var date: Date?
        
        assert(unixTime != nil, "! unixTime")
        
        if let unixTime = unixTime
        {
            date = Date(timeIntervalSince1970: unixTime)
        }
        return Weather(temperature: temperature, humidity: humidity, windSpeed: windSpeed, summary: summary, date: date)
    }
}
