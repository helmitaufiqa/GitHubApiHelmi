//
//  DashboardCoordinator.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class DashboardCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let navigationVc = NavigationViewController()
        let navigationVm = NavigationViewModel()
        navigationVm.coordinator = self
        navigationVc.viewModel = navigationVm
        self.navigationController.setViewControllers([navigationVc], animated: true)
    }
}
