//
//  Coordinator.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 15/09/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
