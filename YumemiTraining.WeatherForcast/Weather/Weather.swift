//
//  Weather.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation

/// A type that express a weather data.
struct Weather {
    
    var condition: Condition
    var maximumTemperature: Int
    var minimumTemperature: Int
    var date: Date
}

extension Weather : Codable {
    
    enum CodingKeys : String, CodingKey {
        
        case condition = "weather_condition"
        case maximumTemperature = "max_temperature"
        case minimumTemperature = "min_temperature"
        case date = "date"
    }
}
