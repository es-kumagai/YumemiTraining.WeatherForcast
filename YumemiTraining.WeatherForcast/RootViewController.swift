//
//  NewViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
                
        present(makeWeatherViewController(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RootViewController {
    
    /// Make an instance of weather view controller.
    /// - Returns: The created instance.
    func makeWeatherViewController() -> WeatherViewController {
        
        let weatherViewController = storyboard!.instantiateWeatherViewController()!

        weatherViewController.modalPresentationStyle = .fullScreen
        weatherViewController.weatherModel = WeatherModelImpl()
        
        return weatherViewController
    }
}
