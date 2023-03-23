//
//  MainViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 11.02.2023.
//


import UIKit

class CoordinatorViewController: UIViewController {
    
    private let currentNavigationController = UINavigationController()
    
    override func viewDidLoad() {
        checkAuthorization()
    }
    
    private func checkAuthorization() {
        AuthManager().checkAuthorization { [weak self] isAuthorized in
            if isAuthorized {
                self?.presentMapViewController()
            }else{
                self?.presentAuthController()
            }
        }
    }
    
    private func presentAuthController() {
        remove(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = []
        let loginViewController = LoginViewController()
        currentNavigationController.viewControllers = [ loginViewController ]
        addFullScreen(childViewController: currentNavigationController)
        loginViewController.delegate = self
    }
    private func presentMapViewController() {
        remove(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = []
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mapViewController = storyboard.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) as? MapViewController else { return }
        currentNavigationController.viewControllers = [ mapViewController ]
        addFullScreen(childViewController: currentNavigationController)
    }
}

extension CoordinatorViewController: LoginViewControllerDelegate {
    func userWasLogined() {
        presentMapViewController()
    }
}
