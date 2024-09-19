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
    
    func fetchWeatherAsync(with request: Weather.Request, completionHandler: FetchCompletionHandler?) {
        
        do {
            let requestData = try JSONEncoder().encode(request)
            let requestJson = String(data: requestData, encoding: .utf8)!
            
            YumemiWeather.asyncFetchWeather(requestJson) { result in
                
                do {
                    let weatherData = try result.get().data(using: .utf8)!
                    let weather = try JSONDecoder().decode(Weather.self, from: weatherData)
                    
                    completionHandler?(.success(weather))
                }
                catch let error as YumemiWeatherError {
                    
                    completionHandler?(.failure(error))
                }
                catch {

                    completionHandler?(.failure(.unknownError))
                }
            }
        }
        catch is EncodingError {
            
            completionHandler?(.failure(.invalidParameterError))
        }
        catch {
            
            completionHandler?(.failure(.unknownError))
        }
    }
}
