//
//  WeatherRequest.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation
import YumemiWeather

extension Weather {
    
    struct ListRequest {
        var areas: [Area]
        var date: Weather.Date
    }
}

extension Weather.ListRequest : Codable {
}

extension Weather.ListRequest : Equatable {
}

extension Weather.ListRequest {
    
    var jsonString: String {
        let encoder = JSONEncoder()
        return try! String(data: encoder.encode(self), encoding: .utf8)!
    }
}

extension Weather.ListRequest : CustomDebugStringConvertible {
    
    var debugDescription: String {
        "Areas: \(areas), Date: \(date)"
    }
}
