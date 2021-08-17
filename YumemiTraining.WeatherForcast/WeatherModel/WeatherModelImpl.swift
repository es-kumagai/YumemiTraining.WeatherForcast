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
    
    weak var delegate: WeatherModelDelegate?
    
    /// Fetch a weather data with `request`.
    /// - Parameter request: An information to specify an area and a date.
    /// - Returns: The weather data of the point specified with `request`.
    func fetchWeatherAsync(with request: Weather.Request, completionHandler: (() -> Void)? = nil) {
        
        defer {
            
            completionHandler?()
        }
        
        do {
            let requestData = try JSONEncoder().encode(request)
            let requestJson = String(data: requestData, encoding: .utf8)!
            
            YumemiWeather.asyncFetchWeather(requestJson) { result in
                
                do {
                    let weatherData = try result.get().data(using: .utf8)!
                    let weather = try JSONDecoder().decode(Weather.self, from: weatherData)
                    
                    self.delegate?.weatherModel(self, fetchDidSucceed: weather, request: request)
                }
                catch {
                    
                    self.delegate?.weatherModel(self, fetchDidFailWithError: error, request: request)
                }
            }
        }
        catch is EncodingError {
            
            delegate?.weatherModel(self, fetchDidFailWithError: YumemiWeatherError.invalidParameterError, request: request)
        }
        catch {
            
            delegate?.weatherModel(self, fetchDidFailWithError: error, request: request)
        }
    }
}
