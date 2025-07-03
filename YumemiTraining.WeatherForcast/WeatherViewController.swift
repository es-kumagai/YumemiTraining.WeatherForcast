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

    @IBOutlet private var weatherImageView: UIImageView!
    @IBOutlet private var maximumTemperatureLabel: UILabel!
    @IBOutlet private var minimumTemperatureLabel: UILabel!
    
    @IBOutlet private var reloadButton: UIBarButtonItem!

    @IBOutlet private var weatherFetchingActivityIndicator: UIActivityIndicatorView!
    
    enum DataSource {
        case fetching(with: WeatherModel, currentArea: Area)
        case fixed(Weather, area: Area)
    }
    
    /// The data source.
    var dataSource: DataSource!
    
    /// The model for fetching a weather data.
    var weatherModel: WeatherModel? {
        switch dataSource! {
        case .fetching(let model, _):
            model
            
        case .fixed:
            nil
        }
    }
    
    var hasWeatherModel: Bool {
        switch dataSource! {
        case .fetching:
            true
            
        case .fixed:
            false
        }
    }
    
    /// The current area.
    var currentArea: Area! {
        switch dataSource {
        case .fetching(_, let area), .fixed(_, let area):
            area
            
        case nil:
            nil
        }
    }
    
    /// The queue for fetching a weather data.
    var fetchingQueue = DispatchQueue(label: "Fetching")
    
    deinit {
    
        NSLog("\(self) has been deinitialized.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hasWeatherModel {
            navigationItem.setRightBarButton(reloadButton, animated: false)
        }
        clearLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if case .fixed(let weather, let area) = dataSource {
            applyToView(weather: weather, in: area)
        }
        
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
        
        if hasWeatherModel {
            reloadWeather()
        }
    }
}

extension WeatherViewController {
    
    /// Reset the labels for temperature.
    func clearLabels() {
        minimumTemperatureLabel.text = "--"
        maximumTemperatureLabel.text = "--"
    }
    
    /// Apply `weather` data to view.
    /// - Parameter weather: A weather data applying to view.
    func applyToView(weather: Weather, in area: Area) {
        weatherImageView.image = weather.condition.imageWithTintColor
        minimumTemperatureLabel.text = String(weather.minimumTemperature)
        maximumTemperatureLabel.text = String(weather.maximumTemperature)
    }
    
    /// Fetch current weather state and show in `weatherImageView` then the weather state will be received through delegate.
    func reloadWeather() {
        
        guard let weatherModel else {
            preconditionFailure("Cannot reload weather data because no weather model were specified.")
        }
        
        self.weatherFetchingActivityIndicator.startAnimating()
        
        Task { [unowned self] in
            
            defer {
                self.weatherFetchingActivityIndicator.stopAnimating()
            }
            
            let request = Weather.Request(area: currentArea, date: .now)
            
            do {
                let weather = try await weatherModel.fetchWeather(with: request)
                applyToView(weather: weather, in: currentArea)
                
            } catch {
                presentErrorAlert(message: error.localizedDescription, ofTitle: "Failed to fetch weather")
            }            
        }
    }
}

