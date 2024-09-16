//
//  NetworkServiceProvider.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

protocol NetworkServiceProvider {
    func execute<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
