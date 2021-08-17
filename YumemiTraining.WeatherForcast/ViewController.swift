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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func reloadButtonDidPush(_ sender: Any) {
        
        reloadWeather()
    }
}

extension ViewController {
    
    /// Fetch current weather state and show in `weatherImageView`.
    func reloadWeather() {
        
        let weatherString = YumemiWeather.fetchWeather()
        
        guard let weather = Weather(rawValue: weatherString) else {

            fatalError("Unexpected weather '\(weatherString)' was fetched.")
        }
        
        weatherImageView.image = weather.image
    }
}
