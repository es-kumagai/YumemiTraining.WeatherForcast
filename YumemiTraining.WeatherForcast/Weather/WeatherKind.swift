//
//  WeatherKind.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

extension Weather {
    
    /// A type that express a kind of weather.
    enum Kind : String {
        
        case sunny = "sunny"
        case cloudy = "cloudy"
        case rainy = "rainy"
    }
}

extension Weather.Kind : Codable {
    
}
