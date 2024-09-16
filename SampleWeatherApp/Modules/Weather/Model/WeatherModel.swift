//
//  WeatherModel.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation

protocol WeatherModelRepresentable {
    var city: String { get }
    var tempMin: Double { get }
    var tempMax: Double { get }
}

struct WeatherModel: Decodable, WeatherModelRepresentable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: WeatherDetail
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    var city: String {
        return name
    }
    
    var tempMin: Double {
        return main.tempMin
    }
    
    var tempMax: Double {
        return main.tempMax
    }
    
    var iconURL: String? {
        if let iconName = weather.first?.icon {
            return "\(NetworkConfig.iconBaseURL)/img/wn/\(iconName)@2x.png"
        }
        return nil
    }    
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Main
struct WeatherDetail: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
