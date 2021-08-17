//
//  WeatherModelDelegate.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import YumemiWeather

protocol WeatherModelDelegate : AnyObject {
    
    func weatherModel(_ model: WeatherModel, fetchWillStartWithRequest: Weather.Request)
    func weatherModel(_ model: WeatherModel, fetchDidSucceed weather: Weather, request: Weather.Request)
    func weatherModel(_ model: WeatherModel, fetchDidFailWithError error: Error, request: Weather.Request)
}
