//
//  DependencyFactory.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct DependencyFactory {

    // MARK: - Repository

    static func darkModeRepository() -> DarkModeRepository {
        let userDefaultManager = UserDefaultManager()
        return DefaultDarkModeRepository(userDefaultManger: userDefaultManager)
    }

    static func guideRepository() -> GuideRepository {
        return DefaultGuideRepository()
    }

    static func locationRepository() -> LocationRepository {
        let locationManager = LocationManger()
        return DefaultLocationRepository(locationManager: locationManager)
    }

    static func konkukInfoRepository() -> KonkukInfoRepository {
        return DefaultKonkukInfoRepository()
    }

    static func userRepository() -> UserRepository {
        return DefaultUserRepository()
    }
}
