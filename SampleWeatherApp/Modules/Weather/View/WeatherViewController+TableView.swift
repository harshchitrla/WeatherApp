//
//  WeatherViewController+TableView.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 13/09/24.
//

import Foundation
import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let weatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell {
            let weatherData = viewModel.getWeatherData()
            let weatherModel = weatherData[indexPath.row]
            weatherTableViewCell.configureCell(weatherModelRepresentable: weatherModel)
            return weatherTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherData = viewModel.getWeatherData()
        let weatherModel = weatherData[indexPath.row]
        coordinator?.navigateToDetailView(weatherData: weatherModel)
    }
}
