//
//  NavigationViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

class NavigationViewController: UITabBarController {

    var viewModel: NavigationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        self.viewControllers = [
            viewModel.displayUsers(),
            viewModel.displayRepositories(),
            viewModel.displayIssues()
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.selectedIndex = 0
        
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor(named: "mainGray")!, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineThickness: 2.0, side: .top)
    }

}

extension NavigationViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor(named: "mainGray")!, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineThickness: 2.0, side: .top)
    }
}
