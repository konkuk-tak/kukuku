//
//  ViewController.swift
//  kukuku
//
//  Created by youtak on 2023/03/01.
//

import Combine
import CoreLocation
import UIKit

import FlexLayout
import PinLayout

class HomeViewController: UIViewController {

    // MARK: - Property

    private var homeView: HomeView {
        guard let view = view as? HomeView else {
            return HomeView()
        }
        return view
    }

    private var homeViewModel: HomeViewModel

    private var userUpdateSubject = PassthroughSubject<Void, Never>()
    private var userScoreUpdateSubject = PassthroughSubject<Void, Never>()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Life Cycle

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeButtonPublisher()
        bind()
    }

    private func configureNavigationBar() {
        let label = UILabel()
        label.textColor = .dynamicBlack
        label.text = "AppName".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationController?.navigationBar.tintColor = .green
        navigationItem.backButtonTitle = ""
    }

    // MARK: - Input & Output Bind

    private func bind() {
        let viewDidLoad = Just(Void()).eraseToAnyPublisher()
        let userScore = userUpdateSubject.eraseToAnyPublisher()
        let userScoreUpdate = userScoreUpdateSubject.eraseToAnyPublisher()
        let checkCanPlay = homeView.arButtonPublisher().eraseToAnyPublisher()

        let input = HomeViewModel.Input(
            viewDidLoad: viewDidLoad,
            userUpdate: userScore,
            userScoreUpdate: userScoreUpdate,
            checkCanPlay: checkCanPlay
        )
        let output = homeViewModel.transform(input: input)

        output.darkMode
            .sink { [weak self] darkModeKind in
                self?.handleDarkMode(darkModeKind: darkModeKind)
            }
            .store(in: &cancellable)

        output.userScoreInfo
            .merge(with: output.userUpdateScoreInfo)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleScoreUpdateError(error)
                case .finished:
                    return
                }
            }, receiveValue: { [weak self] score in
                self?.handleScore(score)
            })
            .store(in: &cancellable)

        output.canPlay
            .sink { [weak self] canPlay in
                self?.handleCanPlay(canPlay)
            }
            .store(in: &cancellable)
    }

    // MARK: - Method
    private func handleDarkMode(darkModeKind: DarkModeKind?) {
        guard let darkModeKind = darkModeKind else {
            return
        }
        DarkModeManager.mode(darkModeKind: darkModeKind)
    }

    private func handleScoreUpdateError(_ error: Error) {
        if error is KeychainError {
            showOkayAlert(title: "Alert Title Key Chain Error", message: "Alert Description Key Chain Error")
        } else {
            showOkayAlert(title: "Error", message: "An error occurred during the update.")
        }
    }

    private func handleScore(_ score: Int?) {
        guard let score = score else {
            showOkayAlert(title: "Error", message: "Alert Description Key Chain Error")
            return
        }
        homeView.update(score: score)
    }

    private func handleCanPlay(_ canPlay: Bool?) {
        guard let canPlay = canPlay else {
            showOkayAlert(title: "Error", message: "Alert Description Invalid Information")
            return
        }

        if canPlay {
            moveToARGame()
        } else {
            showOkayAlert(title: "Alert Title Hamburger", message: "Alert Description Hamburger")
        }
    }

    private func subscribeInitiateUser(settingViewController: SettingViewController) {
        settingViewController.initDataPublisher()
            .sink { [weak self] _ in
                self?.userUpdateSubject.send(Void())
            }
            .store(in: &cancellable)
    }
}

// MARK: - Button Publisher

extension HomeViewController {
    private func subscribeButtonPublisher() {
        homeView.konkukInfoListButtonPublisher()
            .sink { [weak self] _ in
                self?.moveToKonukInfoList()
            }
            .store(in: &cancellable)

        homeView.guideButtonPublisher()
            .sink { [weak self] _ in
                self?.moveToGuide()
            }
            .store(in: &cancellable)

        homeView.settingButtonPublisher()
            .sink { [weak self] _ in
                self?.moveToSetting()
            }
            .store(in: &cancellable)
    }
}

extension HomeViewController {

    // MARK: - Navigation
    private func moveToKonukInfoList() {
        let userListCount = homeViewModel.user.listCount
        let konkukInfoListViewModel = DependencyFactory.konkukInfoListViewModel(
            userListCount: userListCount,
            currentLanguage: AppManager.currentLanguage
        )
        let konkukInfoListViewController = KonkukInfoListViewController(konkukInfoListViewModel: konkukInfoListViewModel)
        self.navigationController?.pushViewController(konkukInfoListViewController, animated: true)
    }

    private func moveToGuide() {
        let guideViewModel = DependencyFactory.guideViewModel(currentLanguage: AppManager.currentLanguage)
        let guideViewController = GuideViewController(viewModel: guideViewModel)
        self.navigationController?.pushViewController(guideViewController, animated: true)
    }

    private func moveToSetting() {
        let settingViewModel = DependencyFactory.settingViewModel(
            user: self.homeViewModel.user,
            currentLanguage: AppManager.currentLanguage
        )
        let settingViewController = SettingViewController(settingViewModel: settingViewModel)
        self.subscribeInitiateUser(settingViewController: settingViewController)
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }

    private func moveToARGame() {
        let isDeveloperMode = homeViewModel.isDeveloperMode()
        let arGameViewModel = DependencyFactory.arGameViewModel(isDeveloperMode: isDeveloperMode)
        let arGameViewController = ARGameViewController(arGameViewModel: arGameViewModel)
        arGameViewController.modalPresentationStyle = .fullScreen
        arGameViewController.transitioningDelegate = self
        arGameViewController.didDismiss = { [weak self] in
            self?.userScoreUpdateSubject.send(Void())
            self?.moveToKonkukInfoDetail()
        }
        present(arGameViewController, animated: true)
    }

    private func moveToKonkukInfoDetail() {
        guard let konkukInfo = homeViewModel.nextKonkukInfo() else { return }
        let konkukInfoDetailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
        konkukInfoDetailViewController.modalPresentationStyle = .fullScreen
        present(konkukInfoDetailViewController, animated: true)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let arButtonFrame = homeView.arButtonFrame() else {
            return PresentTransition(originFrame: .zero)
        }
        print("arButton", arButtonFrame)
        return PresentTransition(originFrame: arButtonFrame)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let arButtonFrame = homeView.arButtonFrame() else {
            return DismissTransition(originFrame: .zero)
        }
        return DismissTransition(originFrame: CGRect(x: 156, y: 718, width: 80, height: 80))
    }
}
