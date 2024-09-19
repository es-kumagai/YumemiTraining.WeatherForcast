//
//  Weather.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation

/// A type that express a weather data.
struct Weather {
    
    var kind: Kind
    var maximumTemperature: Int
    var minimumTemperature: Int
    var date: Date
}

extension Weather : Codable {
    
    enum CodingKeys : String, CodingKey {
        
        case kind = "weather"
        case maximumTemperature = "max_temp"
        case minimumTemperature = "min_temp"
        case date = "date"
    }
}
