//
//  AppCoordinator.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let splashScreenCoordinator = SplashScreenCoordinator(navigationController: navigationController)
        
        childCoordinator.append(splashScreenCoordinator)
        splashScreenCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
