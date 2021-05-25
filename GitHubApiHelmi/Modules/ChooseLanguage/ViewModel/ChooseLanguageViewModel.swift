//
//  ChooseLanguageViewModel.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

final class ChooseLanguageViewModel {
    var coordinator: ChooseLanguageCoordinator?
    
    func startDashboard() {
        coordinator?.startDashboard()
    }
    
    func selectedLanguage(lang: String, key: String, text: String) -> String {
        let selectedLanguage = lang
        let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: key, value: text, table: nil)
        
        return localizedText
    }
}
