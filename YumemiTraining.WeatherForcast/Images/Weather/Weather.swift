//
//  Weather.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation

/// A type that express a weather data.
struct Weather {
    
    var kind: Kind
    var maximumTemperature: Int
    var minimumTemperature: Int
    var date: Date
}

/// The formatter that convert date from/to ISO8601 style.
private let dateFormatter = ISO8601DateFormatter()

extension Weather : Decodable {
    
    enum CodingKeys : String, CodingKey {
        
        case kind = "weather"
        case maximumTemperature = "maxTemp"
        case minimumTemperature = "minTemp"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let dateString = try dateFormatter.date(from: container.decode(String.self, forKey: .date)) else {
            
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Invalid date format.")
        }
        
        kind = try container.decode(Kind.self, forKey: .kind)
        maximumTemperature = try container.decode(Int.self, forKey: .maximumTemperature)
        minimumTemperature = try container.decode(Int.self, forKey: .minimumTemperature)
        date = dateString
    }
}
