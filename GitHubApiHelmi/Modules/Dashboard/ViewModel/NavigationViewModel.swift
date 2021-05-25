//
//  NavigationViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class NavigationViewModel {
    var coordinator: DashboardCoordinator?
    
    func displayUsers() -> UIViewController {
        
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Users", value: "Choose Language...", table: nil)
        
        // Create Tab one
        let tabOne = UsersViewController()
        let tabOneVM = UserViewModel()
        tabOneVM.coordinator = coordinator
        tabOne.viewModel = tabOneVM
        let userLocalize = localizedText
        let tabOneBarItem = UITabBarItem(title: userLocalize, image: nil, selectedImage: nil)
        
        tabOne.tabBarItem = tabOneBarItem
        
        return tabOne
    }
    
    func displayRepositories() -> UIViewController {
        
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Repository", value: "Choose Language...", table: nil)
        
        let tabTwo = RepositoryViewController()
        let tabTwoVM = RepositoryViewModel()
        tabTwoVM.coordinator = coordinator
        tabTwo.viewModel = tabTwoVM
        let repoLocalize = localizedText
        let tabTwoBarItem2 = UITabBarItem(title: repoLocalize, image: nil, selectedImage: nil)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        return tabTwo
    }
    
    func displayIssues() -> UIViewController {
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Issue", value: "Choose Language...", table: nil)
        
        let tabThree = IssueViewController()
        let tabThreeVM = IssueViewModel()
        tabThreeVM.coordinator = coordinator
        tabThree.viewModel = tabThreeVM
        let issueLocalize = localizedText
        let tabTwoBarItem3 = UITabBarItem(title: issueLocalize, image: nil, selectedImage: nil)
        
        tabThree.tabBarItem = tabTwoBarItem3
        
        return tabThree
    }
}
