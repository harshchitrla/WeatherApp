//
//  NetworkError.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

// NetworkError enum can have different cases based on the different scenarios. For the sample app I have added couple of scenarios.
enum NetworkError: Error {
    case responseNotFound
    case networkOffline
    case internalServerError
    case error(_ errorString: String)
}
