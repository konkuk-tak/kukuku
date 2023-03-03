//
//  DefaultLocationRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Combine
import CoreLocation
import Foundation

struct DefaultLocationRepository: LocationRepository {

    private let locationManager: LocationManger

    func requestAuthorization() -> AnyPublisher<AuthorizationStatus, Never> {
        locationManager.authorizationPublisher()
            .map { status in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    return .allow
                case .denied, .restricted:
                    return .denied
                case .notDetermined:
                    return .notDetermined
                @unknown default:
                    print("미래")
                    return .allow
                }
            }
            .eraseToAnyPublisher()
    }

    func requestLocation() -> AnyPublisher<CLLocation, Never> {
        return locationManager.locationPublisher()
    }
}
