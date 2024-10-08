//
//  WeatherViewModel.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

protocol WeatherViewModelRepresentable: ViewStateRepresentable {
    func getWeatherDataForCity(_ name: String)
    func getWeatherDataForLocation(with latitude: Double, longitude: Double)
    func numberOfRows() -> Int
    func getWeatherData() -> [WeatherModel]
    func loadWeatherDataFromPreviousSearch()
}

final class WeatherViewModel: WeatherViewModelRepresentable, DispatchTaskPerformer {
    
    struct Constants {
        static let currentLocation = "currentLocation"
        static let searchLocation = "searchLocation"
        static let lastLocationName = "lastLocationName"
    }
    
    private let weatherService: WeatherServiceRepresentable
    private var weatherData = [String: WeatherModel]()
    
    var viewState: ((ViewState) -> Void)?
    
    /// init - Method to initialise WeatherViewModel
    /// - Parameters:
    ///     - weatherService:class which confirms to WeatherServiceRepresentable protocol
    init(weatherService: WeatherServiceRepresentable) {
        self.weatherService = weatherService
    }
    
    func getWeatherData() -> [WeatherModel] {
        return Array(weatherData.values)
    }
    
    func numberOfRows() -> Int {
        return weatherData.count
    }
    
    // Method to get weather data of the search location
    func getWeatherDataForCity(_ name: String) {
        weatherService.getWeatherDataForCity(name) { [weak self] result in
            guard let self = self else { return }
            // Added performTaskOnMainThread method to avoid thread switching in unit test cases which will cause unnecessary adding of delays in unit test cases
            self.performTaskOnMainThread {
                switch result {
                case .success(let weatherModel):
                    self.weatherData[Constants.searchLocation] = weatherModel
                    self.updateLocationNameInDefaults(name: name)
                    self.viewState?(.update)
                case .failure(let error):
                    self.viewState?(.error(error: error.localizedDescription))
                }
            }
        }
    }
    
    // Method to get weather data of the previous search
    func loadWeatherDataFromPreviousSearch() {
        if let cityName = UserDefaults.standard.object(forKey: Constants.lastLocationName) as? String {
            getWeatherDataForCity(cityName)
        }
    }
    
    func updateLocationNameInDefaults(name: String) {
        UserDefaults.standard.set(name, forKey: Constants.lastLocationName)
    }
    
    // Method to get weather data of the current location
    func getWeatherDataForLocation(with latitude: Double, longitude: Double) {
        weatherService.getWeatherDataForLocation(with: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else { return }
            // Added performTaskOnMainThread method to avoid thread switching in unit test cases which will cause unnecessary adding of delays in unit test cases
            self.performTaskOnMainThread {
                switch result {
                case .success(let weatherModel):
                    self.weatherData[Constants.currentLocation] = weatherModel
                    self.viewState?(.update)
                case .failure(let error):
                    self.viewState?(.error(error: error.localizedDescription))
                }
            }
        }
    }
    
}
