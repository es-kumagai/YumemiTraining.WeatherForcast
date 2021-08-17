//
//  Image.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit

extension UIImage {
    
    /// The weather icon represents sunny.
    static let sunny = #imageLiteral(resourceName: "Sunny")
    
    /// The weather icon represents cloudy.
    static let cloudy = #imageLiteral(resourceName: "Cloudy")
    
    /// The weather icon represents rainy.
    static let rainy = #imageLiteral(resourceName: "Rainy")
}

extension Weather {
    
    var image: UIImage {
        
        switch self {

        case .sunny:
            return .sunny
            
        case .cloudy:
            return .cloudy
            
        case .rainy:
            return .rainy
        }
    }
}
