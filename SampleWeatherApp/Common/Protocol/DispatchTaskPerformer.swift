//
//  DispatchTaskPerformer.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 16/09/24.
//

import Foundation

protocol DispatchTaskPerformer {
    func performTaskOnMainThread(_ task: @escaping ()->())
}

typealias Seconds = Double

extension DispatchTaskPerformer {
    
    func performTaskOnMainThread(_ task: @escaping ()->()) {
        DispatchQueue.main.async(execute: task)
    }
}
