//
//  ViewState.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 15/09/24.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case error(error: String)
    case loaded
    case update
}

protocol ViewStateRepresentable {
    var viewState: ((ViewState) -> Void)? { get set }
}
