//
//  WeatherDate.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import Foundation

extension Weather {
    
    /// A date that compatible with WeatherAPI date format.
    struct Date {
        
        var rawDate: Foundation.Date

        /// The formatter that uses convert date from/to the formatted string used by WeatherAPI.
        private static let dateFormatter: DateFormatter = {

            let dateFormatter = DateFormatter()
            
            dateFormatter.calendar = Calendar.current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            return dateFormatter
        }()

        /// The formatter that uses convert date from/to the formatted string used by WeatherAPI.
        private static let dateFormatterForDisplay: DateFormatter = {

            let dateFormatter = DateFormatter()
            
            dateFormatter.calendar = Calendar.current
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            
            return dateFormatter
        }()
    }
}

extension Weather.Date {
    
    init() {
        
        self.init(rawDate: Date())
    }
}

extension Weather.Date : Codable {

    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        guard let date = try Self.dateFormatter.date(from: container.decode(String.self)) else {
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format.")
        }
        
        rawDate = date
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        try container.encode(Self.dateFormatter.string(from: rawDate))
    }
}

extension Weather.Date : Comparable {

    static func < (lhs: Weather.Date, rhs: Weather.Date) -> Bool {
        
        lhs.rawDate < rhs.rawDate
    }
}

extension Weather.Date : CustomStringConvertible {
    
    var description: String {
        
        Self.dateFormatterForDisplay.string(from: rawDate)
    }
}
