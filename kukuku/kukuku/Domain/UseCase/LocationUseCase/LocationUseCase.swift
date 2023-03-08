//
//  LocationUseCase.swift
//  kukuku
//
//  Created by youtak on 2023/03/03.
//

import Combine
import Foundation

protocol LocationUseCase {
    func isInRange(isDeveloperMode: Bool) -> AnyPublisher<LocationStatus, Never>
    func authorizationPublisher() -> AnyPublisher<AuthorizationStatus, Never>
}
