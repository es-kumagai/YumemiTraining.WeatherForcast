//
//  NewViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit

class RootViewController: UIViewController {

    private(set) var weatherModel: WeatherModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherModel = WeatherModelImpl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
                
        present(makeWeatherTableViewController(), animated: true)
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
        storyboard!.instantiateWeatherViewController(with: weatherModel, modalPresentationStyle: .fullScreen)!
    }
    
    func makeWeatherTableViewController() -> WeatherTableViewController {
        storyboard!.instantiateWeatherTableViewController(with: weatherModel, modalPresentationStyle: .fullScreen)!
    }
}
