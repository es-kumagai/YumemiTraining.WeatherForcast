//
//  WeatherTableViewCell.swift
//  YumemiTraining.WeatherForcast
//
//  Created by 熊谷 友宏 on 2025/06/26.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherTableViewCell"
    
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var minimumTemperatureLabel: UILabel!
    @IBOutlet var maximumTemperatureLabel: UILabel!
    
    var weatherListItem: WeatherList.Item? {
        didSet {
            switch weatherListItem {
            case let item?:
                apply(item)
                
            case nil:
                clear()
            }
        }
    }
    
    private func apply(_ item: WeatherList.Item) {
        weatherImageView.image = item.info.condition.imageWithTintColor
        cityLabel.text = "\(item.area)"
        minimumTemperatureLabel.text = "\(item.info.minimumTemperature)"
        maximumTemperatureLabel.text = "\(item.info.maximumTemperature)"
    }
    
    private func clear() {
        weatherImageView.image = nil
        cityLabel.text = "--"
        minimumTemperatureLabel.text = "--"
        maximumTemperatureLabel.text = "--"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
}
