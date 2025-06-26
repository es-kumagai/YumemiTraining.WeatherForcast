//
//  Storyboard.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit
import YumemiWeather

extension UIStoryboard {
    
    static let weatherViewControllerID = "WeatherViewController"
    static let weatherTableViewControllerID = "WeatherTableViewController"
    
    /// Instantiate weather view controller.
    /// - Returns: An instance of weather view controller.
    func instantiateWeatherViewController(with weatherModel: WeatherModel, modalPresentationStyle: UIModalPresentationStyle) -> WeatherViewController? {
        guard let viewController = instantiateViewController(identifier: Self.weatherViewControllerID) as? WeatherViewController else {
            return nil
        }
        
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.dataSource = .fetching(with: weatherModel, currentArea: .Tokyo)
        
        return viewController
    }

    func instantiateWeatherViewController(with weather: Weather, in area: Area, modalPresentationStyle: UIModalPresentationStyle) -> WeatherViewController? {
        guard let viewController = instantiateViewController(identifier: Self.weatherViewControllerID) as? WeatherViewController else {
            return nil
        }
        
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.dataSource = .fixed(weather, area: area)
        
        return viewController
    }

    func instantiateWeatherTableViewController(with weatherModel: WeatherModel, modalPresentationStyle: UIModalPresentationStyle) -> WeatherTableViewController? {
        guard let viewController = instantiateViewController(withIdentifier: Self.weatherTableViewControllerID) as? WeatherTableViewController else {
            return nil
        }
        
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.weatherModel = weatherModel
        
        return viewController
    }
}
