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
    private let gameCoordinates: [GameCoordinate] = []
    private var authorizationStatus: AuthorizationStatus
    private var cancellable = Set<AnyCancellable>()

    private enum Constant {
        static let targetDistance: Double = 30
    }

    init(
        locationRepository: LocationRepository,
        cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
        authorizationStatus: AuthorizationStatus
    ) {
        self.locationRepository = locationRepository
        self.cancellable = cancellable
        self.authorizationStatus = authorizationStatus
    }

    func isInRange() -> AnyPublisher<LocationStatus, Never> {
        locationRepository.requestLocation()
            .map { location in
                self.isInRange(location: location)
            }
            .eraseToAnyPublisher()
    }

    func requestAuthorization() -> AuthorizationStatus {
        return authorizationStatus
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

    private func subscribeStatus() {
        locationRepository.requestAuthorization()
            .sink { [weak self] status in
                self?.authorizationStatus = status
            }
            .store(in: &cancellable)
    }
}