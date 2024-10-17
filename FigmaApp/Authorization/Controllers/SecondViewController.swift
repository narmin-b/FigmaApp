//
//  SecondViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func didFinish(user: User)
}


class SecondViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var iconClick = false
    let imageIcon = UIImageView()
    private var user: User?
    weak var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        configureView()
        }
    
    private func configureView() {
        let img = UIImageView(image: UIImage(named: "bg"))
        img.alpha = 0.3
        img.contentMode = .scaleAspectFill  // Centers the image in the UIImageView
        img.translatesAutoresizingMaskIntoConstraints = false
        
        bgView.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            img.widthAnchor.constraint(equalTo: bgView.widthAnchor),
            img.heightAnchor.constraint(equalTo: bgView.heightAnchor)
        ])
        
        configureLabels()
        configureFullnameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureButton()
        configureTextButton()
    }
    
    private func configureLabels() {
        createLabel.text = "Create Account"
        createLabel.font = UIFont(name: "Elephant", size: 36)
        textLabel.text = "Find the things that you love!"
        textLabel.font = UIFont(name: "Inter", size: 15)
    }
    
    private func configureFullnameTextField() {
        fullnameLabel.text = "Full Name"
        fullnameLabel.font = UIFont(name: "Red Hat Display", size: 10)
        fullnameTextField.font = UIFont(name: "Red Hat Display", size: 10)
        fullnameTextField.layer.cornerRadius = 7
        fullnameTextField.layer.borderWidth = 1
        fullnameTextField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
    }
    
    private func configureEmailTextField() {
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.layer.cornerRadius = 7
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
    }
    
    private func configurePasswordTextField() {
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        passwordTextField.tintColor = .black
        
        imageIcon.image = UIImage(systemName: "eye.fill")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.fill")?.size.width ?? 20, height: UIImage(systemName: "eye.fill")?.size.height ?? 20)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.fill")?.size.width ?? 20, height: UIImage(systemName: "eye.fill")?.size.height ?? 20)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        if iconClick {
            iconClick = false
            tappedImage?.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(systemName: "eye.slash.fill")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    private func configureButton() {
        signupButton.backgroundColor = .authButton
        signupButton.layer.cornerRadius = 7
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        signupButton.tintColor = .white
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func signupButtonTapped() {
        signUpButtonClicked()
    }
    
    private func configureTextButton() {
        loginLabel.text = "Already have an account?"
        loginLabel.font = UIFont(name: "Red Hat Display", size: 12)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 12)
        loginButton.tintColor = .systemBlue
        loginButton.titleLabel?.attributedText = NSAttributedString(string: "Login", attributes:
                                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func loginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    fileprivate func signUpButtonClicked() {
        guard checkValidation() else {
            print(#function, "fieldler bosh ola bilmez")
            return
        }
        guard let name = fullnameTextField.text, let password = passwordTextField.text, let mail = emailTextField.text else {return}
        user = User(fullname: name, email: mail, password: password)
        guard let user = user else {return}
        UserDefaults.standard.set(user.fullname ?? "", forKey: "username")
        delegate?.didFinish(user: user)
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func checkValidation() -> Bool {
        guard let name = fullnameTextField.text, let password = passwordTextField.text, let mail = emailTextField.text else {return false}
        if (isEmailValid() && isPasswordValid() && isfullNameValid()) {
            errorBorderOff(emailTextField)
            errorBorderOff(passwordTextField)
            errorBorderOff(fullnameTextField)
            return true
        }
        else{
            if !isEmailValid() {
                errorBorderOn(emailTextField)
            } else {errorBorderOff(emailTextField)}
            if !isPasswordValid() {
                errorBorderOn(passwordTextField)
            } else {errorBorderOff(passwordTextField)}
            if !isfullNameValid() {
                errorBorderOn(fullnameTextField)
            } else {errorBorderOff(fullnameTextField)}
            return false
        }
    }
}

extension SecondViewController {
        
    private func isEmailValid() -> Bool {
        let email = emailTextField.text ?? ""
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isPasswordValid() -> Bool {
        return passwordTextField.text!.count >= 6
    }
    
    private func isfullNameValid() -> Bool {
        let fullName = fullnameTextField.text ?? ""
        let regex = "[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: fullName)
    }
    
    private func errorBorderOn(_ textfield: UITextField) {
        textfield.layer.borderColor = UIColor(.red).cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 7
    }
    
    private func errorBorderOff(_ textfield: UITextField) {
        textfield.layer.cornerRadius = 7
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(named: "black")?.cgColor
    }
}
    

