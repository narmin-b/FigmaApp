//
//  ThirdViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    var iconClick = false
    let imageIcon = UIImageView()
    var registerInfo: User = User(email: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        UserDefaults.standard.setValue(1, forKey: "loginType")
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        configureEmailTextField()
        configurePasswordTextField()
        configureButton()
        configureTextButton()
    }
    
    private func configureLabels() {
        welcomeLabel.text = "Hey, welcome   Back!"
        welcomeLabel.font = UIFont(name: "Elephant", size: 36)
        continueLabel.text = "continue with email"
        continueLabel.font = UIFont(name: "Inter", size: 15)
    }
    
    private func configureEmailTextField() {
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.layer.cornerRadius = 7
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        emailTextField.delegate = self
    }
    
    private func configureButton() {
        loginButton.backgroundColor = .authButton
        loginButton.layer.cornerRadius = 7
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func showMain() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToMain()
        }
    }
    
    @objc fileprivate func loginButtonTapped() {
        showMain()
    }
    
    private func configureTextButton() {
        signupLabel.text = "Don’t have an account?"
        signupLabel.font = UIFont(name: "Red Hat Display", size: 12)
        
        let signupTitle = NSAttributedString(string: "SignUp", attributes: [
            .font: UIFont(name: "Red Hat Display", size: 12)!,
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        signupButton.setAttributedTitle(signupTitle, for: .normal)
        
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }

    @objc fileprivate func signupButtonClicked() {
        showRegisterController()
    }

    private func showRegisterController() {
        let controller = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController ?? SecondViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func configurePasswordTextField() {
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        passwordTextField.tintColor = .black
        passwordTextField.delegate = self
        
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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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
    
}

extension ThirdViewController: SecondViewControllerDelegate {
    func didFinish(user: User) {
        emailTextField.text = user.email
        passwordTextField.text = user.password
    }
}

