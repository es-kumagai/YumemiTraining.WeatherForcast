//
//  WeatherRequest.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation
import YumemiWeather

extension Weather {
    
    struct Request {

        var area: Area
        var date: Weather.Date
    }
}

extension Weather.Request : Codable {
    
}

extension Weather.Request : Equatable {
    
}

extension Weather.Request {
    
    var jsonString: String {
       
        let encoder = JSONEncoder()
        
        return try! String(data: encoder.encode(self), encoding: .utf8)!
    }
}

extension Weather.Request : CustomDebugStringConvertible {
    
    var debugDescription: String {
        
        "Area: \(area), Date: \(date)"
    }
}
