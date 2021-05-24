//
//  SplashScreenViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class SplashScreenViewModel {
    var coordinator: SplashScreenCoordinator?
    
    func moveToChoosLanguange() {
        coordinator?.moveToChooseLanguage()
    }
}
