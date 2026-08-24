//
//  ViewController.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 05/06/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var loginView: LoginView?
    var auth: Auth?
    var alert: AlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        auth = Auth.auth()
        isEnableLoginButton(false)
        loginView?.delegate(delegate: self)
        loginView?.configTextField(delegate: self)
//        updateUIForMode()
    }
    
    override func loadView() {
        loginView = LoginView()
        alert = AlertController(controller: self)
        view = loginView
    }
    
    private func validateTextField() {
        if (loginView?.emailTextField.text ?? "").isValid(validType: .email) && (loginView?.passwordTextField.text ?? "").isValid(validType: .password) {
            isEnableLoginButton(true)
            isEnableCreateButton(true)
        } else {
            isEnableLoginButton(false)
            isEnableCreateButton(false)
        }
    }
    
    private func isEnableLoginButton(_ isEnable: Bool) {
        if isEnable {
            loginView?.loginButton.backgroundColor = UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1)
            loginView?.loginButton.isEnabled = true
            loginView?.loginButton.alpha = 1
        } else {
            loginView?.loginButton.backgroundColor = UIColor(red: 100/255, green: 21/255, blue: 21/255, alpha: 1)
            loginView?.loginButton.isEnabled = false
            loginView?.loginButton.alpha = 0.4
        }
    }
    
    private func isEnableCreateButton(_ isEnable: Bool) {
        if isEnable {
            loginView?.createButton.backgroundColor = UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1)
            loginView?.createButton.isEnabled = true
            loginView?.createButton.alpha = 1
        } else {
            loginView?.createButton.backgroundColor = UIColor(red: 100/255, green: 21/255, blue: 21/255, alpha: 1)
            loginView?.createButton.isEnabled = false
            loginView?.createButton.alpha = 0.4
        }
    }
}

extension LoginViewController: LoginProtocol {
    
    func tappedCreateButton() {
        auth?.createUser(withEmail: self.loginView?.emailTextField.text ?? "", password: self.loginView?.passwordTextField.text ?? "") { user, error in
            if error != nil{
                self.alert?.getAlert(title: "Error ao criar conta", message: "Falha na conexão")
            } else {
                let homeVC = HomeViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true)
            }
        }
    }
    
    func tappedLoginButton() {
        auth?.signIn(withEmail: self.loginView?.emailTextField.text ?? "", password: self.loginView?.passwordTextField.text ?? "") { user, error  in
            if error != nil {
                self.alert?.getAlert(title: "Error ao logar", message: "Email ou senha invalidos")
            } else {
                let homeVC = HomeViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        var isValid: Bool = false
        
        switch textField {
        case loginView?.emailTextField:
            isValid = !text.isEmpty && text.isValid(validType: .email)
            
        case loginView?.passwordTextField:
            isValid = !text.isEmpty && text.isValid(validType: .password)
        default:
            break
        }
        
        if isValid {
            textField.layer.borderColor = UIColor(red: 12/255, green: 13/255, blue: 13/255, alpha: 1).cgColor
            textField.layer.borderWidth = 2
        } else {
            textField.layer.borderColor = UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1).cgColor
            textField.layer.borderWidth = 3
        }
        
        validateTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView?.emailTextField {
            loginView?.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
