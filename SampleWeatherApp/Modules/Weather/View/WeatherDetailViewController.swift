//
//  WeatherDetailViewController.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 15/09/24.
//

import UIKit
import SwiftUI

class WeatherDetailViewController: UIViewController {
    
    var weatherModel: WeatherModel
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let hostingController = UIHostingController(rootView: WeatherDetailView(weatherModel: weatherModel))
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }

}
