//
//  LoginViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 01.02.2023.
//

import UIKit

protocol LoginViewControllerDelegate : AnyObject {
    func userWasLogined()
}

class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupButtons()
        setupActions()
    }

    private func setupTextFields() {
        emailTextField.placeholder = "Введите ваш email"
        passwordTextField.placeholder = "Введите ваш пароль"
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupButtons() {
        loginButton.setTitle("Войти", for: .normal)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
    }
   
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonWasPressed), for: .touchUpInside)
    }
    
    private func checkValidEntry()->UserModel? {
        guard let email = emailTextField.text, !email.isEmpty else { return nil }
        guard let password = passwordTextField.text, !password.isEmpty else { return nil }
    let user = UserModel(email: email, password: password)
        return user
    }

    @objc private func loginButtonWasPressed() {
       
        delegate?.userWasLogined()
    }
    
    
    @objc private func registerButtonWasPressed() {
        let registrationVC = RegistrationViewController(nibName: String(describing: RegistrationViewController.self), bundle: nil)
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}

    
extension LoginViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.view.endEditing(true)
         return false
     }
}

