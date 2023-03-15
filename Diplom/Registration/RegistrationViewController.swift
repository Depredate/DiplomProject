//
//  RegistrationViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 04.02.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    @IBOutlet weak var registerButton: UIButton!
 
   override func viewDidLoad() {
       super.viewDidLoad()
       setupTextFiends()
       setupButtons()
       setupActions()
   }
 
   private func setupTextFiends() {
       emailTextField.placeholder = "Введите gmail"
       passwordTextField.placeholder = "Введите пароль"
       repeatPasswordTextField.placeholder = "Повторите пароль"
       passwordTextField.isSecureTextEntry = true
       repeatPasswordTextField.isSecureTextEntry = true
       emailTextField.delegate = self
       passwordTextField.delegate = self
       repeatPasswordTextField.delegate = self
    
       
   }
 
   private func setupButtons() {
       registerButton.setTitle("Зарегистрироваться", for: .normal)
   }

   private func setupActions() {
       registerButton.addTarget(self, action: #selector(registrationButtonWasPressed), for: .touchUpInside)
   }
 
   private func checkValidEntry()->UserModel? {
       guard let email = emailTextField.text, !email.isEmpty else { return nil }
       guard let password = passwordTextField.text, !password.isEmpty else { return nil }
       guard let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else { return nil }
       guard password == repeatPassword else { return nil }
       let user = UserModel(email: email, password: password)
       return user
       
   }
 }


extension RegistrationViewController {
    @objc private func registrationButtonWasPressed() {
    
        let user = checkValidEntry()
        guard let user else {
        showMessage(title: "Ошибка", message: "Проверьте корректность ведённых данных")
            return }
        AuthManager().createUser(user: user)  { [ weak self ]result in
            switch result {
                    
                case .success( _ ):
                    print("regano")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showMessage(title: "Ошибка", message: error.localizedDescription )
            }
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         self.view.endEditing(true)
         return false
     }
}
