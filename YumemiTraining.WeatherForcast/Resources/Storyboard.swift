//
//  Storyboard.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit

extension UIStoryboard {
    
    static var weatherViewControllerID = "WeatherViewController"
    
    /// Instantiate weather view controller.
    /// - Returns: An instance of weather view controller.
    func instantiateWeatherViewController() -> ViewController? {
        
        guard let viewController = instantiateViewController(identifier: Self.weatherViewControllerID) as? ViewController else {
            
            return nil
        }
        
        return viewController
    }
}
