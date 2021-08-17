//
//  WeatherModel.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import Foundation

protocol WeatherModel : AnyObject {
    
    func fetchWeather(with request: Weather.Request) throws -> Weather
}
