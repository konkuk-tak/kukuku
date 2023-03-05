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
        let userScoreUpdate = userScoreSubject.eraseToAnyPublisher()
        let input = HomeViewModel.Input(viewDidLoad: viewDidLoad, userScoreUpdate: userScoreUpdate)
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
                    self?.showOkayAlert(title: "에러", message: "유저 정보를 불러오는데 에러가 발생했습니다. \(error)")
                case .finished:
                    return
                }
            }, receiveValue: { [weak self] score in
                self?.handleScore(score)
            })
            .store(in: &cancellable)
    }

    // MARK: - Method
    private func handleDarkMode(darkModeKind: DarkModeKind?) {
        guard let darkModeKind = darkModeKind else {
            return
        }
        DarkModeManager.mode(darkModeKind: darkModeKind)
    }

    private func handleScore(_ score: Int) {
        homeView.update(score: score)
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
                let settingViewModel = DependencyFactory.settingViewModel()
                let settingViewController = SettingViewController()
                self?.navigationController?.pushViewController(settingViewController, animated: true)
            }
            .store(in: &cancellable)

        homeView.arButtonPublisher()
            .sink { [weak self] _ in
                let arGameViewModel = DependencyFactory.arGameViewModel()
                let arGameViewController = ARGameViewController(arGameViewModel: arGameViewModel)
                arGameViewController.modalPresentationStyle = .fullScreen
                arGameViewController.didDismiss = { [weak self] in
                    self?.moveToKonkukInfoDetail()
                }
                self?.present(arGameViewController, animated: true)
            }
            .store(in: &cancellable)
    }

    private func moveToKonkukInfoDetail() {
        let konkukInfo = KonkukInfo(id: "k31", imageURL: nil, title: "시험용", description: String(repeating: "ㅋ", count: 200))
        let konkukInfoDetailViewController = KonkukInfoDetailViewController(konkukInfo: konkukInfo)
        konkukInfoDetailViewController.modalPresentationStyle = .fullScreen
        konkukInfoDetailViewController.willDismiss = { [weak self] in
            self?.userScoreSubject.send(Void())
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
