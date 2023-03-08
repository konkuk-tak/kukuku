//
//  KonkukInfoUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import XCTest

@testable import kukuku

final class KonkukInfoUseCaseTests: XCTestCase {

    private var konkukInfoRepository: KonkukInfoRepository!
    private var konkukInfoUseCase: KonkukInfoUseCase!

    override func setUpWithError() throws {
        self.konkukInfoRepository = DefaultKonkukInfoRepository()
        self.konkukInfoUseCase = DefaultKonkukInfoUseCase(konkukInfoRepository: konkukInfoRepository)
    }

    override func tearDownWithError() throws {
    }

    func test_konkukInfoList_korean_10() throws {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: .korean, count: 10)
        XCTAssertEqual(userKonkukInfoList.maxCount, 30)
        XCTAssertEqual(userKonkukInfoList.list.count, 10)
    }

    func test_konkukInfoList_korean_30() throws {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: .korean, count: 30)
        XCTAssertEqual(userKonkukInfoList.maxCount, 30)
        XCTAssertEqual(userKonkukInfoList.list.count, 30)
    }

    // 데이터 count 보다 많은 count를 요청했을 경우 -> 데이터 count만큼만 리턴함
    func test_konkukInfoList_korean_31() throws {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: .korean, count: 31)
        XCTAssertEqual(userKonkukInfoList.maxCount, 30)
        XCTAssertEqual(userKonkukInfoList.list.count, 30)
    }

    func test_konkukInfoList_english_10() throws {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: .englishUS, count: 10)
        XCTAssertEqual(userKonkukInfoList.maxCount, 30)
        XCTAssertEqual(userKonkukInfoList.list.count, 10)
    }

    // 데이터 count 보다 많은 count를 요청했을 경우 -> 데이터 count만큼만 리턴함
    func test_konkukInfoList_english_31() throws {
        let userKonkukInfoList = konkukInfoUseCase.infoList(language: .englishUS, count: 31)
        XCTAssertEqual(userKonkukInfoList.maxCount, 30)
        XCTAssertEqual(userKonkukInfoList.list.count, 30)
    }

    func test_korean_info_1st_konkuk_university() throws {
        let index = 1 - 1
        let konkukInfo = try XCTUnwrap(konkukInfoUseCase.info(language: .korean, index: index))
        XCTAssertEqual(konkukInfo.title, "건국대학교")
    }

    func test_korean_info_15th_glass_greenhouse() throws {
        let index = 15 - 1
        let konkukInfo = try XCTUnwrap(konkukInfoUseCase.info(language: .korean, index: index))
        XCTAssertEqual(konkukInfo.title, "유리 온실")
    }

    func test_korean_info_31th_isNil() throws {
        let index = 31 - 1
        let konkukInfo = konkukInfoUseCase.info(language: .korean, index: index)
        XCTAssertNil(konkukInfo)
    }

    func test_english_info_1st_konkuk_university() throws {
        let index = 1 - 1
        let konkukInfo = try XCTUnwrap(konkukInfoUseCase.info(language: .englishUS, index: index))
        XCTAssertEqual(konkukInfo.title, "Konkuk University")
    }

    func test_english_info_15th_glass_greenhouse() throws {
        let index = 15 - 1
        let konkukInfo = try XCTUnwrap(konkukInfoUseCase.info(language: .englishUS, index: index))
        XCTAssertEqual(konkukInfo.title, "Glass Greenhouse")
    }
}
