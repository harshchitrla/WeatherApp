//
//  WeatherViewController+LocationManager.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 13/09/24.
//

import Foundation

// MARK: - LocationManagerDelegate Delegate
extension WeatherViewController: LocationManagerDelegate {
    func locationManager(_ locationManager: LocationManager, latitude: Double, longitude: Double) {
        viewModel.getWeatherDataForLocation(with: latitude, longitude: longitude)
    }
}
