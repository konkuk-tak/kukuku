//
//  KonkukInfoListViewModel.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Combine
import Foundation

final class KonkukInfoListViewModel {

    private (set)var konkukInfoList: [KonkukInfo] = []
    private (set)var maxCount: Int = 0
    private var konkukInfoUseCase: KonkukInfoUseCase

    init(konkukInfoUseCase: KonkukInfoUseCase) {
        self.konkukInfoUseCase = konkukInfoUseCase
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Int, Never>
    }

    struct Output {
        let infoList: AnyPublisher<Void?, Never>
    }

    func transform(input: Input) -> Output {

        let konkukInfoList = input.viewDidLoad
            .map { [weak self] count in
                self?.fetchKonkukInfoList(count: count)
            }
            .eraseToAnyPublisher()

        return Output(infoList: konkukInfoList)
    }

    func konkukInfo(index: Int) -> KonkukInfo {
        return konkukInfoList[index]
    }

    private func fetchKonkukInfoList(count: Int) {
        let userKonkukInfoList = konkukInfoUseCase.infoList(count: count)
        konkukInfoList = userKonkukInfoList.list
        maxCount = userKonkukInfoList.maxCount
    }
}
