//
//  WeatherCoordinator.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 15/09/24.
//

import Foundation
import UIKit

// As we have only one module, I'm creating only coordinator specific to module.
final class WeatherCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let urlSessionProvider = URLSessionProvider()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherService = WeatherService(with: urlSessionProvider)
        let viewModel = WeatherViewModel(weatherService: weatherService)
        let weatherViewController = WeatherViewController(viewModel: viewModel)
        weatherViewController.coordinator = self
        navigationController.pushViewController(weatherViewController, animated: true)
    }
    
    func navigateToDetailView(weatherData: WeatherModel) {
        let weatherDetailViewController = WeatherDetailViewController(weatherModel: weatherData)
        navigationController.pushViewController(weatherDetailViewController, animated: true)
    }
}
