//
//  NewViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by Tomohiro Kumagai on 2021/08/17.
//

import UIKit

class NewViewController: UIViewController {

    var weatherViewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherViewController = storyboard!.instantiateWeatherViewController()!
        weatherViewController.modalPresentationStyle = .fullScreen
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        present(weatherViewController, animated: true)
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
