//
//  WeatherModelImpl.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import YumemiWeather
import Foundation

@objcMembers
final class WeatherModelImpl : NSObject, WeatherModel {
    
    func fetchWeather(with request: Weather.Request) throws -> Weather {
        
        try YumemiWeather.fetchWeather(with: request)
    }
}
