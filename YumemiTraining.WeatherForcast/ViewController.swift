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
    
    /// The area that supposing we are in.
    var currentArea = "tokyo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    /// Fetch current weather state and show in `weatherImageView`.
    func reloadWeather() {
        
        do {

            let weatherString = try YumemiWeather.fetchWeather(at: currentArea)
        
            guard let weather = Weather(rawValue: weatherString) else {
                
                fatalError("Unexpected weather '\(weatherString)' was fetched.")
            }
            
            weatherImageView.image = weather.imageWithTintColor
        }
        catch let error as YumemiWeatherError {
            
            let title = "Failed to fetch weather"
            let message: String
            
            switch error {
            
            case .invalidParameterError:
                message = "The parameter '\(currentArea)' was not valid."
            case .unknownError:
                message = "A unknown error occurred while fetching weather in \(currentArea)."
            }

            presentErrorAlert(message: message, ofTitle: title)
        }
        catch {
            
            fatalError("Unexpected error: \(error)")
        }
    }
}
