//
//  LocationManager.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 12/09/24.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ locationManager: LocationManager, latitude: Double, longitude: Double)
}


final class LocationManager: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationManagerDelegate?
    var location: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        delegate?.locationManager(self, latitude: Double(location.latitude), longitude: Double(location.longitude))
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                print("Error, location unknown", error)
            case .denied:
                print("Error, Location denied", error)
            default:
                print("Error getting location", error)
            }
        }
    }
}
