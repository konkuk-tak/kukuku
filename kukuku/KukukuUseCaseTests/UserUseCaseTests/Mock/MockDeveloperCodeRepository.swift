//
//  MockDeveloperCodeRepository.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Foundation

@testable import kukuku

final class MockDeveloperCodeRepository: DeveloperCodeRepository {
    func code() -> String? {
        return "DeveloperCode"
    }
}
