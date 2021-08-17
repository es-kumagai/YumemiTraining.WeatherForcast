//
//  WeatherAPI.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import YumemiWeather
import Foundation

extension YumemiWeather {
    
    /// Fetch a weather data with `request`.
    /// - Parameter request: An information to specify an area and a date.
    /// - Throws: YumemiWeatherError, DecodingError
    /// - Returns: The weather data of the point specified with `request`.
    static func fetchWeather(_ request: Weather.Request) throws -> Weather {
        
        do {

            let requestData = try JSONEncoder().encode(request)
            let requestJson = String(data: requestData, encoding: .utf8)!
        
            let weatherString = try fetchWeather(requestJson)
            let weatherData = weatherString.data(using: .utf8)!
            
            return try JSONDecoder().decode(Weather.self, from: weatherData)
        }
        catch is EncodingError {
            
            throw YumemiWeatherError.invalidParameterError
        }
    }
}
