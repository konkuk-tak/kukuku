//
//  ARGameViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import Foundation

final class ARGameViewModel {

    private var isDeveloperMode: Bool
    private var locationUseCase: LocationUseCase

    init(isDeveloperMode: Bool, locationUseCase: LocationUseCase) {
        self.isDeveloperMode = isDeveloperMode
        self.locationUseCase = locationUseCase
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let locationAuthorizationStatus: AnyPublisher<AuthorizationStatus, Never>
        let rangeStatus: AnyPublisher<LocationStatus, Never>
    }

    func transform(input: Input) -> Output {
        let locationAuthorizationStatus = locationAuthorizationStatus()
        let rangeStatus = locationUseCase.isInRange(isDeveloperMode: isDeveloperMode).eraseToAnyPublisher()
        return Output(locationAuthorizationStatus: locationAuthorizationStatus, rangeStatus: rangeStatus)
    }

    private func locationAuthorizationStatus() -> AnyPublisher<AuthorizationStatus, Never> {
        return locationUseCase.authorizationPublisher()
    }
}
