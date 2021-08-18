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
    var weatherModel: WeatherModel!
    
    /// The queue for fetching a weather data.
    var fetchingQueue = DispatchQueue(label: "Fetching")
    
    deinit {
    
        NSLog("\(self) has been deinitialized.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearTemperatureLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveApplicationDidBecomeActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @IBAction func reloadButtonDidPush(_ sender: Any) {
        
        reloadWeather()
    }
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

extension WeatherViewController {
    
    func receiveApplicationDidBecomeActiveNotification(_ notification: Notification) {
        
        reloadWeather()
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
    
    /// Fetch current weather state and show in `weatherImageView` then the `handler` will be invoked when the weather state will be received.
    func reloadWeather(completionHandler handler: WeatherModel.FetchCompletionHandler? = nil) {

        DispatchQueue.main.async {

            self.weatherFetchingActivityIndicator.startAnimating()
        }
        
        let request = Weather.Request(area: currentArea, date: Weather.Date())
        
        weatherModel.fetchWeatherAsync(with: request) { result in
                        
            handler?(result)

            DispatchQueue.main.async {
                
                self.weatherFetchingActivityIndicator.stopAnimating()
                
                do {
                    try self.applyToView(weather: result.get())
                }
                catch {
                    
                    var message: String {
                    
                        switch error {
                        
                        case YumemiWeatherError.invalidParameterError:
                            return "The parameter was not valid."
                            
                        default:
                            return "A unknown error occurred while fetching weather."
                        }
                    }
                    
                    self.presentErrorAlert(message: message, ofTitle: "Failed to fetch weather")
                }
            }
        }
    }
}
