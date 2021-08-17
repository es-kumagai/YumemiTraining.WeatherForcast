//
//  ViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/05.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!

    /// The area that supposing we are in.
    var currentArea = "tokyo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearTemperatureLabels()
    }

    @IBAction func reloadButtonDidPush(_ sender: Any) {
        
        reloadWeather()
    }
}

extension ViewController {
    
    /// Present an error alert.
    /// - Parameters:
    ///   - message: The message to convey to a user.
    ///   - ofTitle: the text for this alert.
    ///   - actionHandler: The action that will be invoked
    ///                    when touch the 'OK' button in the alert.
    func presentErrorAlert(message: String, ofTitle: String, actionHandler: ((_ action: UIAlertAction) -> Void)? = nil) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: actionHandler)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    /// Reset the labels for temperature.
    func clearTemperatureLabels() {
        
        minimumTemperatureLabel.text = "--"
        maximumTemperatureLabel.text = "--"
    }
    
    /// Fetch current weather state and show in `weatherImageView`.
    func reloadWeather() {
        
        let encoder = JSONEncoder()

        let request = Weather.Request(area: currentArea, date: Weather.Date())
        let requestJson = try! String(data: encoder.encode(request), encoding: .utf8)!

        do {

            let decoder = JSONDecoder()
            
            let weatherString = try YumemiWeather.fetchWeather(requestJson)
            let weatherData = weatherString.data(using: .utf8)!
            let weather = try decoder.decode(Weather.self, from: weatherData)
        
            weatherImageView.image = weather.kind.imageWithTintColor
            minimumTemperatureLabel.text = String(weather.minimumTemperature)
            maximumTemperatureLabel.text = String(weather.maximumTemperature)
        }
        catch let error as YumemiWeatherError {
            
            let message: String
            
            switch error {
            
            case .invalidParameterError:
                message = "The parameter '\(request)' was not valid."
            case .unknownError:
                message = "A unknown error occurred while fetching weather with \(request)."
            }

            presentErrorAlert(message: message, ofTitle: "Failed to fetch weather")
        }
        catch let error as DecodingError {
            
            fatalError("Decoding error: \(error)")
        }
        catch {
            
            fatalError("Unexpected error: \(error)")
        }
    }
}
