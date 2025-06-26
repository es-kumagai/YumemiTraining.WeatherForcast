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
    
    /// Fetch weather list with `request` data.
    func fetchWeatherList(with request: Weather.ListRequest) async throws -> WeatherList
}

extension WeatherModel {
    
    func fetchWeatherList(in areas: some Sequence<Area>, at date: Weather.Date) async throws -> WeatherList {
        
        let request = Weather.ListRequest(areas: Array(areas), date: date)
        
        return try await fetchWeatherList(with: request)
    }
}
