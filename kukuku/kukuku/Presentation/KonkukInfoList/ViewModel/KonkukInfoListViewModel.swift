//
//  KonkukInfoListViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Combine
import Foundation

final class KonkukInfoListViewModel {

    private var konkukInfoUseCase: KonkukInfoUseCase

    init(konkukInfoUseCase: KonkukInfoUseCase) {
        self.konkukInfoUseCase = konkukInfoUseCase
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Int, Never>
    }

    struct Output {
        let infoList: AnyPublisher<UserKonkukInfoList?, Never>
    }

    func transform(input: Input) -> Output {

        let konkukInfoList = input.viewDidLoad
            .map { [weak self] count in
                self?.konkukInfoUseCase.infoList(count: count)
            }
            .eraseToAnyPublisher()

        return Output(infoList: konkukInfoList)
    }
}
