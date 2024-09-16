//
//  Localisation.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 16/09/24.
//

import Foundation

enum LocalisedText: String {
    case minTemp = "MinTemp"
    case maxTemp = "MaxTemp"
    case humidity = "Humidity"
    
    var localised: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
