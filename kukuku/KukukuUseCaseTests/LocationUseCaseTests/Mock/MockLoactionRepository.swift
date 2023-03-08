//
//  MockLoactionRepository.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Combine
import CoreLocation.CLLocation
import Foundation

@testable import kukuku

final class MockLocationRepository: LocationRepository {

    var currentLocation: CLLocation!

    func requestAuthorization() -> AnyPublisher<kukuku.AuthorizationStatus, Never> {
        return Just(.denied).eraseToAnyPublisher()
    }

    func requestLocation() -> AnyPublisher<CLLocation, Never> {
        return Just(currentLocation).eraseToAnyPublisher()
    }

    func gameLocation() -> [kukuku.GameCoordinate] {
        return GameCoordinate.create()
    }
}
