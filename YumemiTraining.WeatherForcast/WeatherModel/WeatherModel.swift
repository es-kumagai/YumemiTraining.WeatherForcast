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
        
    /// A type expressing completion handler of fetching.
    typealias FetchCompletionHandler = (_ result: Result<Weather, YumemiWeatherError>) -> Void
    
    /// The instance that acts as the delegate of the model.
    var delegate: WeatherModelDelegate? { get set }
    
    /// Fetches `request`ed weather data.
    /// - Parameters:
    ///   - request: The information to specify an area and a date.
    ///   - completionHandler: A handler that will be invoked when weather data is received.
    func fetchWeatherAsync(with request: Weather.Request, completionHandler: FetchCompletionHandler?)
    
    /// Fetches `request`ed weather data.
    /// - Parameter request: The information to specify an area and a date.
    func fetchWeatherAsync(with request: Weather.Request)
}
