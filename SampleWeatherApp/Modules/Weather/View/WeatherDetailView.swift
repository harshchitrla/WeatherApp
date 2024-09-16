//
//  WeatherDetailView.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 15/09/24.
//

import SwiftUI

struct WeatherDetailView: View {
    var weatherModel: WeatherModel
    
    var minTempValue: String {
        return "\(LocalisedText.minTemp.localised): \(weatherModel.main.tempMin)"
    }
    
    var maxTempValue: String {
        return "\(LocalisedText.maxTemp.localised): \(weatherModel.main.tempMax)"
    }
    
    var humidity: String {
        return "\(LocalisedText.humidity.localised): \(weatherModel.main.humidity)"
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(weatherModel.city)
                    .font(.title)
                Spacer()
                if let iconURL = weatherModel.iconURL {
                    // AsyncImage loads the image from the url and cache the image
                    AsyncImage(url: URL(string: iconURL))
                        .frame(width: 50, height: 50)
                }
            }
            Text(minTempValue)
                .font(.title3)
                .accessibilityLabel(minTempValue)
            Text(maxTempValue)
                .font(.title3)
                .accessibilityLabel(maxTempValue)
            Text(humidity)
                .font(.title3)
                .accessibilityLabel(humidity)
        }
        .padding(16)
    }
}
