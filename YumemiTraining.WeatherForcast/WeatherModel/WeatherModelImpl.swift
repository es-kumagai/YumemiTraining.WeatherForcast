//
//  WeatherModelImpl.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/18.
//

import YumemiWeather
import Foundation

final class WeatherModelImpl : NSObject, WeatherModel {
    
    func fetchWeather(with request: Weather.Request) async throws -> Weather {
        
        try await withCheckedThrowingContinuation { continuation in
            
            do {
                let requestData = try JSONEncoder().encode(request)
                let requestJson = String(data: requestData, encoding: .utf8)!
                
                let weatherString = try YumemiWeather.syncFetchWeather(requestJson)
                
                let weatherData = weatherString.data(using: .utf8)!
                let weather = try JSONDecoder().decode(Weather.self, from: weatherData)
                
                continuation.resume(returning: weather)
            }
            catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func fetchWeatherList(with request: Weather.ListRequest) async throws -> WeatherList {

        let weatherList = try await YumemiWeather.asyncFetchWeatherList(request.jsonString)
        let weatherListData = weatherList.data(using: .utf8)!
        
        return try JSONDecoder().decode(WeatherList.self, from: weatherListData)
    }
}
