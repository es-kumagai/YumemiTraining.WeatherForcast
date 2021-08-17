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
    
    /// Returns an image painted with the tint color
    /// that representing the weather expressed by this instance.
    var imageWithTintColor: UIImage {
    
        image.withTintColor(tintColor)
    }
    
    /// Returns an image that representing
    /// the weather expressed by this instance.
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
    
    /// Returns a tint color that representing
    /// the weather expressed by this instance.
    var tintColor: UIColor {
        
        switch self {
        
        case .sunny:
            return .red
            
        case .cloudy:
            return .gray
            
        case .rainy:
            return .blue
        }
    }
}
