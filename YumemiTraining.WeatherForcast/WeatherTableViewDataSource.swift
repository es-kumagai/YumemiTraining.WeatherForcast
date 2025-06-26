//
//  WeatherTableViewDataSource.swift
//  YumemiTraining.WeatherForcast
//
//  Created by 熊谷 友宏 on 2025/06/26.
//

import UIKit
import YumemiWeather

@objcMembers
final class WeatherTableViewDataSource: NSObject, UITableViewDataSource {
    
    /// The model for fetching a weather data.
    var weatherModel: WeatherModel!

    /// The wether data.
    var weatherList = WeatherList()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.weatherListItem = weatherList[indexPath.row]
        
        return cell
    }

    func fetchWeatherList() async throws {
        
        let areas = Area.allCases
        let date = Weather.Date()
        
        weatherList = try await weatherModel.fetchWeatherList(in: areas, at: date)
    }
}
