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
    @IBOutlet weak var hourlyWeatherTableView: UITableView!
    
    var currentWeather: Weather?
    var hourlyWeathers: [Weather]?
    
    
    // FIXME: log show error: "[App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourlyWeatherTableView.delegate = self
        hourlyWeatherTableView.dataSource = self
        //hourlyWeatherTableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: Constants.HourlyWeatherTableViewCellIdentifier)
        //hourlyWeatherTableView.register(nib: UINib(nibName: HourlyWeatherTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.HourlyWeatherTableViewCellIdentifier)
        let nib = UINib(nibName: "HourlyWeatherTableViewCell", bundle: nil)
        hourlyWeatherTableView.register(nib, forCellReuseIdentifier: Constants.HourlyWeatherTableViewCellIdentifier)
        
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
        
        let weatherPresenter = WeatherDataPresenter(weather: currentWeather)
        
        summaryLabel.text = weatherPresenter.summary
        temperatureLabel.text = weatherPresenter.temperature
        humidityLabel.text = weatherPresenter.humidity
        windSpeedLabel.text = weatherPresenter.windSpeed
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
        
        if let weather = hourlyWeathers?[indexPath.row]
        {
            let weatherPresenter = WeatherDataPresenter(weather: weather)
            
            print("cell : \(cell)")
            cell.summaryLabel.text = weatherPresenter.summary
            cell.temperatureLabel.text = weatherPresenter.temperature
            cell.humidityLabel.text = weatherPresenter.humidity
            cell.windSpeedLabel.text = weatherPresenter.windSpeed
            cell.timeLabel.text = weatherPresenter.time
        }
        
        return cell
    }
}
