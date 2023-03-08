//
//  LocationUseCaseTests.swift
//  kukukuUseCaseTests
//
//  Created by youtak on 2023/03/08.
//

import Combine
import CoreLocation.CLLocation
import XCTest

@testable import kukuku

final class LocationUseCaseTests: XCTestCase {

    private var mockLocationRepository: MockLocationRepository!
    private var locationUseCase: LocationUseCase!

    private var cancellable: Set<AnyCancellable>!

    override func setUpWithError() throws {
        self.mockLocationRepository = MockLocationRepository()
        self.locationUseCase = DefaultLocationUseCase(locationRepository: mockLocationRepository)
        self.cancellable = Set<AnyCancellable>()
    }

    func test_authorization_publisher_denied() throws {
        locationUseCase.authorizationPublisher()
            .sink { status in
                XCTAssertEqual(status, .denied)
            }
            .store(in: &cancellable)
    }

    // swiftlint:disable: line_length
    // https://www.google.co.kr/maps/place/37%C2%B032'28.7%22N+127%C2%B004'24.6%22E/data=!3m1!4b1!4m4!3m3!8m2!3d37.541314!4d127.073505?hl=ko
    func test_location_near_statue_success() throws {
        mockLocationRepository.currentLocation = CLLocation(latitude: 37.541314, longitude: 127.073505)

        locationUseCase.isInRange(isDeveloperMode: false)
            .sink { status in
                XCTAssertEqual(status, .success)
            }
            .store(in: &cancellable)
    }

    // https://www.google.co.kr/maps/place/37%C2%B032'27.5%22N+127%C2%B004'23.7%22E/data=!3m1!4b1!4m4!3m3!8m2!3d37.540968!4d127.073254?hl=ko
    func test_location_near_statue_fail() throws {
        mockLocationRepository.currentLocation = CLLocation(latitude: 37.540968, longitude: 127.073254)

        locationUseCase.isInRange(isDeveloperMode: false)
            .sink { status in
                XCTAssertEqual(status, .fail)
            }
            .store(in: &cancellable)
    }

    // https://www.google.co.kr/maps/place/37%C2%B032'32.6%22N+127%C2%B004'36.2%22E/data=!3m1!4b1!4m4!3m3!8m2!3d37.542393!4d127.076726?hl=ko
    
    func test_location_near_chung_sim_dae_success() throws {
        mockLocationRepository.currentLocation = CLLocation(latitude: 37.542393, longitude: 127.076726)

        locationUseCase.isInRange(isDeveloperMode: false)
            .sink { status in
                XCTAssertEqual(status, .success)
            }
            .store(in: &cancellable)
    }

    // https://www.google.co.kr/maps/place/37%C2%B032'33.5%22N+127%C2%B004'34.1%22E/data=!3m1!4b1!4m4!3m3!8m2!3d37.542649!4d127.076144?hl=ko
    
    func test_location_near_chung_sim_dae_fail() throws {
        mockLocationRepository.currentLocation = CLLocation(latitude: 37.542649, longitude: 127.076144)

        locationUseCase.isInRange(isDeveloperMode: false)
            .sink { status in
                XCTAssertEqual(status, .fail)
            }
            .store(in: &cancellable)
    }

    // Apple Infinity Loop, California
    // https://www.google.co.kr/maps/@37.3317451,-122.0302458,19.09z?hl=ko

    func test_location_developer_model() throws {
        mockLocationRepository.currentLocation = CLLocation(latitude: 37.331813, longitude: -122.029607)

        locationUseCase.isInRange(isDeveloperMode: true)
            .sink { status in
                XCTAssertEqual(status, .success)
            }
            .store(in: &cancellable)
    }
}
