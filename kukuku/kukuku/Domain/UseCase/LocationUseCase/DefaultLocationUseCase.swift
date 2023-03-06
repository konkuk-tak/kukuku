//
//  DefaultLocationUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Combine
import CoreLocation
import Foundation

final class DefaultLocationUseCase: LocationUseCase {

    private var locationRepository: LocationRepository
    private var gameCoordinates: [GameCoordinate] = []

    private enum Constant {
        static let targetDistance: Double = 200
    }

    init(
        locationRepository: LocationRepository
    ) {
        self.locationRepository = locationRepository
        self.gameCoordinates = locationRepository.gameLocation()
    }

    func isInRange(isDeveloperMode: Bool) -> AnyPublisher<LocationStatus, Never> {
        if isDeveloperMode {
            return unLimitedRange()
        } else {
            return locationRepository.requestLocation()
                .map { location in
                    self.isInRange(location: location)
                }
                .eraseToAnyPublisher()
        }
    }

    func unLimitedRange() -> AnyPublisher<LocationStatus, Never> {
        return Just(LocationStatus.success).eraseToAnyPublisher()
    }

    func authorizationPublisher() -> AnyPublisher<AuthorizationStatus, Never> {
        return locationRepository.requestAuthorization()
    }

    private func isInRange(location: CLLocation) -> LocationStatus {
        for gameCoordinate in gameCoordinates {
            let gameLocation = CLLocation(latitude: gameCoordinate.latitude, longitude: gameCoordinate.longitude)

            let distance = gameLocation.distance(from: location)
            if distance <= Constant.targetDistance {
                return .success
            }
        }
        return .fail
    }
}
