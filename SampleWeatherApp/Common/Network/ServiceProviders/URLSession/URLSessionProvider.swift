//
//  URLSessionProvider.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

struct URLSessionProvider: NetworkServiceProvider {
    
    //The below method can be updated with related error cases. It is now mapped to only one error case.
    func execute<T>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error("Error: Invalid URL")))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(.error("Error: \(err.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error("Error: Data is corrupted.")))
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(.error("Error: \(decodingError.localizedDescription)")))
                return
            }
            
        }.resume()

    }
}
