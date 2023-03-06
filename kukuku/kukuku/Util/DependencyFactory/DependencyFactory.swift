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

    static func developerCodeRepository() -> DeveloperCodeRepository {
        return DefaultDeveloperCodeRepository()
    }

    static func languageRepository() -> LanguageRepository {
        let userDefaultManger = UserDefaultManager()
        return DefaultLanguageRepository(userDefaultManager: userDefaultManger)
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
        let developerCodeRepository = developerCodeRepository()
        return DefaultUserUseCase(userRepository: userRepository, developerCodeRepository: developerCodeRepository)
    }

    static func languageUseCase() -> LanguageUseCase {
        let languageRepository = languageRepository()
        return DefaultLanguageUseCase(languageRepository: languageRepository)
    }

    // MARK: - ViewModel

    static func homeViewModel() -> HomeViewModel {
        let darkModeUseCase = darkModeUseCase()
        let userUseCase = userUseCase()
        let konkukInfoUseCase = konkukInfoUseCase()
        return HomeViewModel(darkModeUse: darkModeUseCase, userUseCase: userUseCase, konkukInfoUseCase: konkukInfoUseCase)
    }

    static func konkukInfoListViewModel(userListCount: Int) -> KonkukInfoListViewModel {
        let konkukInfoUseCase = konkukInfoUseCase()
        return KonkukInfoListViewModel(userListCount: userListCount, konkukInfoUseCase: konkukInfoUseCase)
    }

    static func guideViewModel() -> GuideViewModel {
        let guideUseCase = guideUseCase()
        return GuideViewModel(guideUseCase: guideUseCase)
    }

    static func settingViewModel(user: User) -> SettingViewModel {
        let userUseCase = userUseCase()
        return SettingViewModel(user: user, userUseCase: userUseCase)
    }

    static func settingDarkModeViewModel() -> SettingDarkModeViewModel {
        let darkModeUseCase = darkModeUseCase()
        return SettingDarkModeViewModel(darkModeUseCase: darkModeUseCase)
    }

    static func settingLanguageViewModel() -> SettingLanguageViewModel {
        let languageUseCase = languageUseCase()
        return SettingLanguageViewModel(languageUseCase: languageUseCase)
    }

    static func arGameViewModel(isDeveloperMode: Bool) -> ARGameViewModel {
        let locationUseCase = locationUseCase()
        return ARGameViewModel(isDeveloperMode: isDeveloperMode, locationUseCase: locationUseCase)
    }
}
