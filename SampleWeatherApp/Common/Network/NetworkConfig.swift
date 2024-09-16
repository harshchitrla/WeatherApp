//
//  NetworkConfig.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

// If I have a time I used to create xcconfig for different environments and add the configuration there.
struct NetworkConfig {
    static let baseURL = "http://api.openweathermap.org"
    static let apiKey = "634d74078fc384a58727d1728b1b2157"
    static let iconBaseURL = "https://openweathermap.org"
}

// If I have time I used to create a generic url request protocol, extension handles request formation based on encoding type.
enum EndPoint {
    case cityName(_ cityName: String)
    case latAndLong(latitude: Double, longitude: Double)
    
    var rawValue: String {
        switch self {
        case .cityName(let cityName):
            return "/data/2.5/weather?q=\(cityName)&appid=\(NetworkConfig.apiKey)"
        case .latAndLong(let latitude, let longitude):
            return "/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(NetworkConfig.apiKey)"
        }
    }
}
