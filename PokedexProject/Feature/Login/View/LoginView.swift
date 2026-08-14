//
//  LoginView.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 07/06/26.
//

import UIKit

class LoginView: UIView {
    
    private weak var delegate: LoginProtocol?
    
    public func delegate(delegate: LoginProtocol?) {
        self.delegate = delegate
    }
    
    public func configTextField(delegate: UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokedex-logo")
        return imageView
    }()
    
    lazy var pokeballImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball-icon")
        imageView.layer.opacity = 0.3
        return imageView
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "text-gray")
        return label
    }()
    
    lazy var emailTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder-gray") as Any]
            )
        textField.textColor = UIColor(named: "text-gray")
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor(red: 12/255, green: 13/255, blue: 13/255, alpha: 1).cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "text-gray")
        return label
    }()
    
    lazy var passwordTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite sua senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder-gray") as Any]
            )
        textField.textColor = UIColor(named: "text-gray")
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor(red: 12/255, green: 13/255, blue: 13/255, alpha: 1).cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 100/255, green: 21/255, blue: 21/255, alpha: 1)
        button.isEnabled = false
        button.alpha = 0.4
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1).cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        return button
    }()
    
    @objc func tappedLoginButton() {
        self.delegate?.tappedLoginButton()
    }
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar conta", for: .normal)
        button.setTitleColor(UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1), for: .normal)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(red: 232/255, green: 48/255, blue: 48/255, alpha: 1).cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(tappedCreateButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedCreateButton() {
        self.delegate?.tappedCreateButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background-white")
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    private func addViews() {
        addSubview(pokeballImageView)
        addSubview(logoImageView)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(createButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            pokeballImageView.topAnchor.constraint(equalTo: topAnchor, constant: -60),
            pokeballImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 90),
            pokeballImageView.heightAnchor.constraint(equalToConstant: 300),
            pokeballImageView.widthAnchor.constraint(equalToConstant: 300),
            
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 180),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
            
            emailLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 45),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 38),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 38),
            
            createButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            createButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
    
}
