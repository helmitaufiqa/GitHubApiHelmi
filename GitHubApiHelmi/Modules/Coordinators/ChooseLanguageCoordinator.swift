//
//  ChooseLanguageCoordinator.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class ChooseLanguageCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let chooseLanguageVc = ChooseLanguageViewController()
        let chooseLanguageVm = ChooseLanguageViewModel()
        chooseLanguageVm.coordinator = self
        chooseLanguageVc.viewModel = chooseLanguageVm
        self.navigationController.pushViewController(chooseLanguageVc, animated: true)
    }
    
    func startDashboard() {
        let dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        childCoordinator.append(dashboardCoordinator)
        dashboardCoordinator.start()
    }
}
