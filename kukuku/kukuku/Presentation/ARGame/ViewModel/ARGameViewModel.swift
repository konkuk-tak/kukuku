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
        print(isDeveloperMode)
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let rangeStatus: AnyPublisher<LocationStatus, Never>
    }

    func transform(input: Input) -> Output {
        let rangeStatus = locationUseCase.isInRange(isDeveloperMode: isDeveloperMode).eraseToAnyPublisher()
        return Output(rangeStatus: rangeStatus)
    }
}
