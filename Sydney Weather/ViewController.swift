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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hourlyWeatherTableView.delegate = self
        //hourlyWeatherTableView.dataSource = self
        hourlyWeatherTableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: Constants.HourlyWeatherTableViewCellIdentifier)
        
        //FIXME: can use operation queue for doing updateAllWeathers only once
        WeatherAPI.getCurrentWeather(with: { [weak self] (weathers, error) in
            self?.currentWeather = weathers?.first
            self?.updateAllWeathers()
        })
        
        WeatherAPI.getHourlyWeathers(with: { [weak self] (weathers, error) in
            self?.hourlyWeathers = weathers
            self?.updateAllWeathers()
        })
    }
    @IBAction func refreshButtonPressed(_ sender: AnyObject)
    {
        updateAllWeathers()
    }
    
    func updateAllWeathers()
    {
        // update current weather
        summaryLabel.text = currentWeather?.summary
        temperatureLabel.text = String(currentWeather?.temperature).appending("°c")
        humidityLabel.text = String(currentWeather?.humidity).appending("%")
        windSpeedLabel.text = String(currentWeather?.windSpeed).appending(" km/h")
        
        // update hourly weathers
        hourlyWeatherTableView.reloadData()
    }
}

/*
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyWeathers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hourlyWeatherTableView.dequeueReusableCell( withIdentifier: NSStringFromClass(HourlyWeatherTableViewCell.self), for: indexPath) as! HourlyWeatherTableViewCell
        
        return cell
    }
}

*/
