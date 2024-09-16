//
//  WeatherService.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

protocol WeatherServiceRepresentable {
    func getWeatherDataForCity(_ name: String, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void)
    func getWeatherDataForLocation(with latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void)
}

// Here I'm marking class as final to avoid dynamic binding
final class WeatherService: WeatherServiceRepresentable {
    
    var serviceProvider: NetworkServiceProvider
    
    // Here I'm injecting the NetworkServiceProvider because in the future if required we can replace it with other service providers like Alamofire without touching WeatherService class.
    init(with serviceProvider: NetworkServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    // I'm passing urlString from here, if I have a time I used to create xcconfig for different environments and add the configuration there.
    func getWeatherDataForCity(_ name: String, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        let urlString = NetworkConfig.baseURL + EndPoint.cityName(name).rawValue
        serviceProvider.execute(urlString: urlString, completion: completion)
    }
    
    func getWeatherDataForLocation(with latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        let urlString = NetworkConfig.baseURL + EndPoint.latAndLong(latitude: latitude, longitude: longitude).rawValue
        serviceProvider.execute(urlString: urlString, completion: completion)
    }
}
