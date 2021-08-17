//
//  ViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/05.
//

import UIKit
import YumemiWeather

@objcMembers
class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!

    @IBOutlet weak var weatherFetchingActivityIndicator: UIActivityIndicatorView!
    
    /// The area that supposing we are in.
    var currentArea = "tokyo"
    
    /// The model for fetching a weather data.
    var weatherModel: WeatherModel! {
        
        didSet {
            weatherModel.delegate = self
        }
    }
    
    /// The queue for fetching a weather data.
    var fetchingQueue = DispatchQueue(label: "Fetching")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearTemperatureLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadWeather), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func reloadButtonDidPush(_ sender: Any) {
        
        reloadWeather()
    }
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

extension WeatherViewController {
    
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
    
    /// Apply `weather` data to view.
    /// - Parameter weather: A weather data applying to view.
    func applyToView(weather: Weather) {
        
        weatherImageView.image = weather.kind.imageWithTintColor
        minimumTemperatureLabel.text = String(weather.minimumTemperature)
        maximumTemperatureLabel.text = String(weather.maximumTemperature)
    }
    
    /// Fetch current weather state and show in `weatherImageView`.
    func reloadWeather(completionHandler: (() -> Void)? = nil) {

        let request = Weather.Request(area: currentArea, date: Weather.Date())
        
        weatherModel.fetchWeatherAsync(with: request, completionHandler: completionHandler)
    }
}

extension WeatherViewController : WeatherModelDelegate {
    
    func weatherModel(_ model: WeatherModel, fetchWillStartWithRequest: Weather.Request) {
        
        DispatchQueue.main.async {
            
            self.weatherFetchingActivityIndicator.startAnimating()
        }
    }
    
    func weatherModel(_ model: WeatherModel, fetchDidSucceed weather: Weather, request: Weather.Request) {
        
        DispatchQueue.main.async {

            self.weatherFetchingActivityIndicator.stopAnimating()
            self.applyToView(weather: weather)
        }
    }
    
    func weatherModel(_ model: WeatherModel, fetchDidFailWithError error: Error, request: Weather.Request) {
        
        DispatchQueue.main.async {

            self.weatherFetchingActivityIndicator.stopAnimating()
            
            switch error {
            
            case let error as YumemiWeatherError:
                
                let message: String
                
                switch error {
                
                case .invalidParameterError:
                    message = "The parameter '\(request)' was not valid."
                    
                case .unknownError:
                    message = "A unknown error occurred while fetching weather with \(request)."
                }
                
                DispatchQueue.main.async {
                    
                    self.presentErrorAlert(message: message, ofTitle: "Failed to fetch weather")
                }
                
            case let error as DecodingError:
                fatalError("Decoding error: \(error)")
                
            default:
                fatalError("Unexpected error: \(error)")
            }
        }
    }
}
