//
//  ViewController.swift
//  Sydney Weather
//
//  Created by allenlinli on 8/17/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var hourlyWeatherTableView: HourlyWeatherTableView!
    
    var currentWeather: Weather?
    var hourlyWeathers: [Weather]?
    
    
    // FIXME: log show error: "[App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourlyWeatherTableView.delegate = self
        hourlyWeatherTableView.dataSource = self
        hourlyWeatherTableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: Constants.HourlyWeatherTableViewCellIdentifier)
        
        //FIXME: can use operation queue for doing updateAllWeathers only once
        WeatherAPI.getCurrentWeather(with: { [weak self] (weathers, error) in
            self?.currentWeather = weathers?.first
            DispatchQueue.main.async {
                self?.updateAllWeathers()
                print("finish updating getCurrentWeather")
            }
        })
        
        WeatherAPI.getHourlyWeathers(with: { [weak self] (weathers, error) in
            self?.hourlyWeathers = weathers
            DispatchQueue.main.async {
                self?.updateAllWeathers()
                print("finish updating getHourlyWeathers")
            }
        })
    }
    @IBAction func refreshButtonPressed(_ sender: AnyObject)
    {
        updateAllWeathers()
    }
    
    func updateCurrentWeather()
    {
        guard let currentWeather = currentWeather else {
            assertionFailure("no currentWeather")
            return
        }
        
        summaryLabel.text = nil
        temperatureLabel.text = nil
        humidityLabel.text = nil
        windSpeedLabel.text = nil
        
        // update current weather
        summaryLabel.text = currentWeather.summary! ?? ""
        
        if let temperature = currentWeather.temperature {
            let cTemperature = Constants.celsius(wtih: temperature)
            temperatureLabel.text = NSString(format:"%.0f", cTemperature).appending("°c")
        }
        
        if let humidity = currentWeather.humidity {
            humidityLabel.text = NSString(format:"%.0f", humidity*100).appending("°%")
        }
        
        if let windSpeed = currentWeather.windSpeed {
            windSpeedLabel.text = NSString(format:"%.0f", windSpeed).appending(" km/h")
        }

        print("start to print")
        print(currentWeather)
        print(summaryLabel.text)
        print(temperatureLabel.text)
        print(humidityLabel.text)
        print(windSpeedLabel.text)
    }
    
    func updateAllWeathers()
    {
        updateCurrentWeather()
        
        // update hourly weathers
        hourlyWeatherTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyWeathers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hourlyWeatherTableView.dequeueReusableCell( withIdentifier: Constants.HourlyWeatherTableViewCellIdentifier, for: indexPath) as! HourlyWeatherTableViewCell
        
        return cell
    }
}
