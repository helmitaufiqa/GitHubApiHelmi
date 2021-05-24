//
//  SplashScreenViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

class SplashScreenViewController: UIViewController {

    var viewModel: SplashScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
