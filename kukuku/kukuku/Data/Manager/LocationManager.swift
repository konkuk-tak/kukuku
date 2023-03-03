//
//  LocationManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Combine
import CoreLocation
import Foundation

final class LocationManger: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var locationSubject = PassthroughSubject<CLLocation, Never>()
    private var authorizationSubject = PassthroughSubject<CLAuthorizationStatus, Never>()

    override init() {
        super.init()
        setLocationPermission()
    }

    private func setLocationPermission() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationSubject.send(location)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationSubject.send(manager.authorizationStatus)
    }
}

extension LocationManger {
    func locationPublisher() -> AnyPublisher<CLLocation, Never> {
        return locationSubject.eraseToAnyPublisher()
    }

    func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never> {
        return authorizationSubject.eraseToAnyPublisher()
    }
}
