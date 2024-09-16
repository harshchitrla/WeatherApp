//
//  WeatherViewModelTests.swift
//  SampleWeatherAppTests
//
//  Created by Harsh Chitrala on 16/09/24.
//

import XCTest
@testable import SampleWeatherApp

final class WeatherViewModelTests: XCTestCase {

    private var viewModel: WeatherViewModel?
    
    override func setUpWithError() throws {
        viewModel = WeatherViewModel(weatherService: MockWeatherService())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetWeatherDataForCity() {
        XCTAssertEqual(viewModel?.getWeatherData().count ?? 1, 0)
        XCTAssertEqual(viewModel?.numberOfRows() ?? 1, 0)
        XCTAssertNil(viewModel?.viewState)
        viewModel?.getWeatherDataForCity("Fremont")
        XCTAssertEqual(viewModel?.getWeatherData().count ?? 0, 1)
        XCTAssertEqual(viewModel?.numberOfRows() ?? 0, 1)
        XCTAssertNotNil(viewModel?.viewState)
    }
    
    func testGetWeatherDataForLocation() {
        XCTAssertEqual(viewModel?.getWeatherData().count ?? 1, 0)
        XCTAssertEqual(viewModel?.numberOfRows() ?? 1, 0)
        XCTAssertNil(viewModel?.viewState)
        viewModel?.getWeatherDataForLocation(with: 24.99, longitude: 34.25)
        XCTAssertEqual(viewModel?.getWeatherData().count ?? 0, 1)
        XCTAssertEqual(viewModel?.numberOfRows() ?? 0, 1)
        XCTAssertNotNil(viewModel?.viewState)
    }
}

class MockWeatherService: WeatherServiceRepresentable {
    func getWeatherDataForCity(_ name: String, completion: @escaping (Result<SampleWeatherApp.WeatherModel, SampleWeatherApp.NetworkError>) -> Void) {
        if let data = loadJSONData(fileName: "WeatherResponse") {
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weatherModel))
            } catch {
                
            }
        }
    }
    
    func getWeatherDataForLocation(with latitude: Double, longitude: Double, completion: @escaping (Result<SampleWeatherApp.WeatherModel, SampleWeatherApp.NetworkError>) -> Void) {
        if let data = loadJSONData(fileName: "WeatherResponse") {
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weatherModel))
            } catch {
                
            }
        }
    }
    
    func loadJSONData(fileName: String) -> Data? {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        return nil
    }
}
