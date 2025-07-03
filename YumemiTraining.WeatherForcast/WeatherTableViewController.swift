//
//  WeatherTableViewController.swift
//  YumemiTraining.WeatherForcast
//  
//  Created by Tomohiro Kumagai on 2024/09/26
//  
//

import UIKit

final class WeatherTableViewController: UIViewController {
    
    /// The table view
    @IBOutlet private var tableView: UITableView!
    
    /// The indicator for fetching.
    @IBOutlet private var weatherFetchingActivityIndicator: UIActivityIndicatorView!
    
    /// The data source for the table view.
    @IBOutlet private var dataSource: WeatherTableViewDataSource!
    
    /// Whether a fetch is currently in progress
    private var isFetching: Bool = false
    
    /// The selected weather list item.
    private var selectedWeatherItem: WeatherList.Item? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }
        
        return dataSource.weatherItem(at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl

        Task { [unowned self] in
            weatherFetchingActivityIndicator.startAnimating()
            await fetchWeatherList()
            weatherFetchingActivityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveApplicationDidBecomeActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func fetchWeatherList() async {
        
        guard !isFetching else {
            return
        }
        
        isFetching = true
        
        defer {
            isFetching = false
        }
        
        do {
            try await dataSource.fetchWeatherList()
            tableView.reloadData()
        } catch {
            presentErrorAlert(message: error.localizedDescription, ofTitle: "Failed to fetch weather")
        }
    }
    
    @objc private func onRefresh(_ sender: UIRefreshControl) {
        Task { [unowned self] in
            await fetchWeatherList()
            sender.endRefreshing()
        }
    }
    
    @objc private func receiveApplicationDidBecomeActiveNotification(_ notification: Notification) {
        
        Task { [unowned self] in
            await fetchWeatherList()
        }
    }
}

extension WeatherTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination = segue.destination as! WeatherViewController
        let weatherItem = selectedWeatherItem!
        
        destination.navigationItem.title = "\(weatherItem.area)"
        destination.dataSource = .fixed(weatherItem.info, area: weatherItem.area)
    }
}
