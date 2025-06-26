//
//  WeatherModel.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import Foundation
import YumemiWeather

/// An abstruct class that includes features around fetching weather data.
protocol WeatherModel : AnyObject {
        
    /// Fetches `request`ed weather data.
    /// - Parameter request: The information to specify an area and a date.
    func fetchWeather(with request: Weather.Request) async throws -> Weather
}
