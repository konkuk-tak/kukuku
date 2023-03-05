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

    // MARK: - UseCase

    static func darkModeUseCase() -> DarkModeUseCase {
        let darkModeRepository = darkModeRepository()
        return DefaultDarkModeUseCase(darkModeRepository: darkModeRepository)
    }

    static func guideUseCase() -> GuideUseCase {
        let guideRepository = guideRepository()
        return DefaultGuideUseCase(guideRepository: guideRepository)
    }

    static func locationUseCase() -> LocationUseCase {
        let locationRepository = locationRepository()
        return DefaultLocationUseCase(locationRepository: locationRepository)
    }

    static func konkukInfoUseCase() -> KonkukInfoUseCase {
        let konkukInfoRepository = konkukInfoRepository()
        return DefaultKonkukInfoUseCase(konkukInfoRepository: konkukInfoRepository)
    }

    static func userUseCase() -> UserUseCase {
        let userRepository = userRepository()
        return DefaultUserUseCase(userRepository: userRepository)
    }

    // MARK: - ViewModel

    static func homeViewModel() -> HomeViewModel {
        let darkModeUseCase = darkModeUseCase()
        let userUseCase = userUseCase()
        let locationUseCase = locationUseCase()
        return HomeViewModel(darkModeUse: darkModeUseCase, userUseCase: userUseCase, locationUseCase: locationUseCase)
    }

    static func konkukInfoListViewModel() -> KonkukInfoListViewModel {
        let konkukInfoUseCase = konkukInfoUseCase()
        return KonkukInfoListViewModel(konkukInfoUseCase: konkukInfoUseCase)
    }

    static func guideViewModel() -> GuideViewModel {
        let guideUseCase = guideUseCase()
        return GuideViewModel(guideUseCase: guideUseCase)
    }

    static func settingViewModel() -> SettingViewModel {
        return SettingViewModel()
    }

    static func settingDarkModeViewModel() -> SettingDarkModeViewModel {
        let darkModeUseCase = darkModeUseCase()
        return SettingDarkModeViewModel(darkModeUseCase: darkModeUseCase)
    }

    static func arGameViewModel() -> ARGameViewModel {
        let locationUseCase = locationUseCase()
        return ARGameViewModel(locationUseCase: locationUseCase)
    }
}
