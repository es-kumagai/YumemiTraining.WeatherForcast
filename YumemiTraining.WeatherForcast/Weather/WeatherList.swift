//
//  WeatherList.swift
//  YumemiTraining.WeatherForcast
//
//  Created by 熊谷 友宏 on 2025/06/26.
//

import YumemiWeather

struct WeatherList: Codable {
    var items: [Item]
}

extension WeatherList {
        
    struct Item: Codable {
        var area: Area
        var info: Weather
    }
}

extension WeatherList {
    
    init() {
        self.init(items: [])
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([Item].self)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(items)
    }
}

extension WeatherList: RandomAccessCollection {
    
    var startIndex: Int {
        items.startIndex
    }
    
    var endIndex: Int {
        items.endIndex
    }
    
    subscript(position: Int) -> WeatherList.Item {
        items[position]
    }
    
    func index(after i: Int) -> Int {
        items.index(after: i)
    }
}
