//
//  LocationRepository.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Combine
import CoreLocation.CLLocation
import Foundation

protocol LocationRepository {
    func requestAuthorization() -> AnyPublisher<AuthorizationStatus, Never>
    func requestLocation() -> AnyPublisher<CLLocation, Never>
}
