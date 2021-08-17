//
//  WeatherModel.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import Foundation

protocol WeatherModel : AnyObject {
    
    var delegate: WeatherModelDelegate? { get set }
    
    func fetchWeatherAsync(with request: Weather.Request, completionHandler: (() -> Void)?)
}
