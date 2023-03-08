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
    let userListCount: Int
    let currentLanguage: LanguageKind

    private var konkukInfoUseCase: KonkukInfoUseCase

    var currentCount: Int { return konkukInfoList.count }

    init(userListCount: Int, currentLanguage: LanguageKind, konkukInfoUseCase: KonkukInfoUseCase) {
        self.userListCount = userListCount
        self.currentLanguage = currentLanguage
        self.konkukInfoUseCase = konkukInfoUseCase
    }

    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let infoList: AnyPublisher<Void?, Never>
    }

    func transform(input: Input) -> Output {

        let konkukInfoList = input.viewDidLoad
            .map { [weak self] _ in
                self?.fetchKonkukInfoList()
            }
            .eraseToAnyPublisher()

        return Output(infoList: konkukInfoList)
    }

    func konkukInfo(index: Int) -> KonkukInfo {
        return konkukInfoList[index]
    }

    private func fetchKonkukInfoList() {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: currentLanguage, count: userListCount)
        konkukInfoList = userKonkukInfoList.list
        maxCount = userKonkukInfoList.maxCount
    }
}
