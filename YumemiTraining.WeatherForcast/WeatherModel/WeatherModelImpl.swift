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
    
    func fetchWeatherAsync(with request: Weather.Request) {
        
        delegate?.weatherModel(self, fetchWillStartWithRequest: request)
        
        DispatchQueue.global().async {
            
            do {

                let requestData = try JSONEncoder().encode(request)
                let requestJson = String(data: requestData, encoding: .utf8)!
                
                let weatherString = try YumemiWeather.syncFetchWeather(requestJson)

                let weatherData = weatherString.data(using: .utf8)!
                let weather = try JSONDecoder().decode(Weather.self, from: weatherData)
                
                self.delegate?.weatherModel(self, fetchDidSucceed: weather, request: request)
            }
            catch is EncodingError {
                
                self.delegate?.weatherModel(self, fetchDidFailWithError: .invalidParameterError, request: request)
            }
            catch let error as YumemiWeatherError {
                
                self.delegate?.weatherModel(self, fetchDidFailWithError: error, request: request)
            }
            catch {
                
                self.delegate?.weatherModel(self, fetchDidFailWithError: .unknownError, request: request)
            }
        }
    }
}
