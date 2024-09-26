//
//  YumemiWeatherError.swift
//  YumemiTraining.WeatherForcast
//  
//  Created by Tomohiro Kumagai on 2024/09/26
//  
//

import Foundation
import YumemiWeather

extension YumemiWeatherError: @retroactive LocalizedError {
 
    public var errorDescription: String? {
        
        switch self {
            
        case .invalidParameterError:
            return "The parameter was not valid."
            
        case .unknownError:
            return "A unknown error occurred while fetching weather."
        }
    }
}
