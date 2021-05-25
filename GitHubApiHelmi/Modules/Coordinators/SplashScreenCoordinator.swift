//
//  SplashScreenCoordinator.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class SplashScreenCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashScreenVc = SplashScreenViewController()
        let splashScreenVm = SplashScreenViewModel()
        splashScreenVm.coordinator = self
        splashScreenVc.viewModel = splashScreenVm
        self.navigationController.setViewControllers([splashScreenVc], animated: true)
    }
    
    func moveToChooseLanguage() {
        let chooseLanguageCoordinator = ChooseLanguageCoordinator(navigationController: navigationController)
        childCoordinator.append(chooseLanguageCoordinator)
        chooseLanguageCoordinator.start()
    }
    
}
