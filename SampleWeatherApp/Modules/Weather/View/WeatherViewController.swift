//
//  WeatherViewController.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import UIKit
import SwiftUI

final class WeatherViewController: UIViewController {
    
    var searchTask: DispatchWorkItem?
    weak var coordinator: WeatherCoordinator?

    private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for a city"
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
       return tableView
    }()
    
    /// init - Method to initialise WeatherViewController
    /// - Parameters:
    ///     - viewModel: class which confirms to WeatherViewModelRepresentable protocol
    init(viewModel: WeatherViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: WeatherViewModelRepresentable
    private let locationManager = LocationManager()
    
    // MARK: - View Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupUI()
        setupTableView()
        registerCell()
        handleViewState()
        viewModel.loadWeatherDataFromPreviousSearch()
    }
    
    // As of now I have handled only update view state. If I have more time, based on view state I would have updated the view.
    private func handleViewState() {
        viewModel.viewState = { [weak self] state in
            guard let self = self else { return }
            if state == ViewState.update {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    private func registerCell() {
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    // MARK: - Setup UI
    // Method to configure UI
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Weather"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

