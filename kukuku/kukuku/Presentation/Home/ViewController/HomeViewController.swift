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

    private var userScoreSubject = PassthroughSubject<Void, Never>()
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
        moveToTargetView()
        testLocation()
    }

    private func configureNavigationBar() {
        let label = UILabel()
        label.textColor = .dynamicBlack
        label.text = "쿠쿠쿠"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationController?.navigationBar.tintColor = .green
        navigationItem.backButtonTitle = ""
    }

    // MARK: - Input & Output Bind

    private func bind() {
        let viewDidLoad = Just(Void()).eraseToAnyPublisher()
        let userScore = userScoreSubject.eraseToAnyPublisher()
        let userScoreUpdate = userScoreUpdateSubject.eraseToAnyPublisher()
        let checkCanPlay = homeView.arButtonPublisher().eraseToAnyPublisher()

        let input = HomeViewModel.Input(
            viewDidLoad: viewDidLoad,
            userScore: userScore,
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
        if let error = error as? KeychainError {
            showOkayAlert(title: "키체인 에러", message: "키체인 에러가 발생했어요. \(error) 개발자에게 문의해주세요. youtaktak@gmail.com")
        } else {
            showOkayAlert(title: "에러", message: "업데이트 중 에러가 발생했어요. \(error)")
        }
    }

    private func handleScore(_ score: Int?) {
        guard let score = score else {
            showOkayAlert(title: "에러", message: "키체인 저장 중 에러가 발생했습니다.")
            return
        }
        homeView.update(score: score)
    }

    private func handleCanPlay(_ canPlay: Bool?) {
        guard let canPlay = canPlay else {
            showOkayAlert(title: "에러", message: "정보를 불러올 수 없어요.")
            return
        }

        if canPlay {
            let arGameViewModel = DependencyFactory.arGameViewModel()
            let arGameViewController = ARGameViewController(arGameViewModel: arGameViewModel)
            arGameViewController.modalPresentationStyle = .fullScreen
            arGameViewController.didDismiss = { [weak self] in
                self?.moveToKonkukInfoDetail()
            }
            present(arGameViewController, animated: true)
        } else {
            showOkayAlert(title: "오늘의 햄버거를 먹었어요", message: "하루에 한 번만 햄버거를 먹을 수 있어요")
        }
    }

    private func subscribeInitiateUser(settingViewController: SettingViewController) {
        settingViewController.initDataPublisher()
            .sink { [weak self] _ in
                self?.userScoreSubject.send(Void())
            }
            .store(in: &cancellable)
    }
}

extension HomeViewController {

    // MARK: - Navigation

    private func subscribeButtonPublisher() {
        homeView.konkukInfoListButtonPublisher()
            .sink { [weak self] _ in
                let konkukInfoListViewModel = DependencyFactory.konkukInfoListViewModel()
                let konkukInfoListViewController = KonkukInfoListViewController(konkukInfoListViewModel: konkukInfoListViewModel)
                self?.navigationController?.pushViewController(konkukInfoListViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.guideButtonPublisher()
            .sink { [weak self] _ in
                let guideViewModel = DependencyFactory.guideViewModel()
                let guideViewController = GuideViewController(viewModel: guideViewModel)
                self?.navigationController?.pushViewController(guideViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.settingButtonPublisher()
            .sink { [weak self] _ in
                guard let self = self else {
                    self?.showOkayAlert(title: "에러", message: "개발자에게 문의해주세요. 에러 코드 [언래핑]")
                    return
                }
                let settingViewModel = DependencyFactory.settingViewModel(user: self.homeViewModel.user)
                let settingViewController = SettingViewController(settingViewModel: settingViewModel)
                self.subscribeInitiateUser(settingViewController: settingViewController)
                self.navigationController?.pushViewController(settingViewController, animated: true)
            }
            .store(in: &cancellable)
    }

    private func moveToKonkukInfoDetail() {
        let konkukInfo = KonkukInfo(id: "k31", imageURL: nil, title: "시험용", description: String(repeating: "ㅋ", count: 200))
        let konkukInfoDetailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
        konkukInfoDetailViewController.modalPresentationStyle = .fullScreen
        konkukInfoDetailViewController.willDismiss = { [weak self] in
            self?.userScoreUpdateSubject.send(Void())
        }
        present(konkukInfoDetailViewController, animated: true)
    }
}

// For fast

#if DEBUG
extension HomeViewController {
    private func moveToTargetView() {
//        let targetViewController = ARGameViewController()
//        targetViewController.modalPresentationStyle = .fullScreen
//        present(targetViewController, animated: true)
//        let konkukInfo = DefaultKonkukInfoRepository().konkukInfoList()![0]
//        let konkukInfoDetailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
//        konkukInfoDetailViewController.modalPresentationStyle = .fullScreen
//        present(konkukInfoDetailViewController, animated: true)
    }

    private func testLocation() {
//        locationManager.requestAuthorization()
    }
}
#endif
