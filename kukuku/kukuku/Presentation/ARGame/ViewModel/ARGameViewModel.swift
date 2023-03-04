//
//  ARGameViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import Foundation

final class ARGameViewModel {

    private var locationUseCase: LocationUseCase

    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let rangeStatus: AnyPublisher<LocationStatus, Never>
    }

    func transform(input: Input) -> Output {
        let rangeStatus = locationUseCase.isInRange()
        return Output(rangeStatus: rangeStatus)
    }
}
