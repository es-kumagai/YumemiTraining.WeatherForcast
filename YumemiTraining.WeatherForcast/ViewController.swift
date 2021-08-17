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
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

extension ViewController {
    
    /// Present an error alert.
    /// - Parameters:
    ///   - message: The message to convey to a user.
    ///   - ofTitle: the text for this alert.
    ///   - actionHandler: The action that will be invoked
    ///                    when touch the 'OK' button in the alert.
    func presentErrorAlert(message: String, ofTitle title: String, actionHandler: ((_ action: UIAlertAction) -> Void)? = nil) {
    
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

        let request = Weather.Request(area: currentArea, date: Weather.Date())
        
        do {
            let weather = try YumemiWeather.fetchWeather(request)
        
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
