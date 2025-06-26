//
//  ViewController.swift
//  YumemiTraining.WeatherForcast
//
//  Created by 熊谷 友宏 on 2025/06/26.
//

import UIKit

extension UIViewController {
    
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
}
