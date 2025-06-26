//
//  Area.swift
//  YumemiTraining.WeatherForcast
//
//  Created by 熊谷 友宏 on 2025/06/26.
//

import YumemiWeather

extension Area: CustomStringConvertible {
    
    public var description: String {
        switch self {
            
        case .Sapporo:
            "札幌"
            
        case .Sendai:
            "仙台"
            
        case .Niigata:
            "新潟"
            
        case .Kanazawa:
            "金沢"
            
        case .Tokyo:
            "東京"
            
        case .Nagoya:
            "名古屋"
            
        case .Osaka:
            "大阪"
            
        case .Hiroshima:
            "広島"
            
        case .Kochi:
            "高知"
            
        case .Fukuoka:
            "福岡"
            
        case .Kagoshima:
            "鹿児島"
            
        case .Naha:
            "那覇"
        }
    }
}
