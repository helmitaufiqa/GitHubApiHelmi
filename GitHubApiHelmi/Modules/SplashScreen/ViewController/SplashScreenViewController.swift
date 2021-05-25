//
//  SplashScreenViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {

    var viewModel: SplashScreenViewModel!
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLottie()
        moveToChooseLanguageVc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func setupLottie() {
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .autoReverse
        animationView?.animationSpeed = 1.0
        view.addSubview(animationView ?? AnimationView())
        animationView?.play()
    }
    
    private func moveToChooseLanguageVc() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.moveToChooseLanguange()
        }
    }
}
