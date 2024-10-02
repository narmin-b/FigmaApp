//
//  SecondViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

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
    @IBOutlet weak var loginTextView: UITextView!

    var iconClick = false
    let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLabels()
        configureFullnameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureButton()
        configureTextButton()
    }

    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            if URL.absoluteString == "loginAction" {
                let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController ?? ThirdViewController()
                present(loginVC, animated: true)
            }
            return true
        }
    
    private func configureView() {
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "Image") ?? UIImage()).withAlphaComponent(0.2)
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
        fullnameTextField.layer.borderColor = UIColor(named: "black")?.cgColor
    }
    
    private func configureEmailTextField() {
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.layer.cornerRadius = 7
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "black")?.cgColor
    }
    
    private func configurePasswordTextField() {
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "black")?.cgColor
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
    
    private func configureButton() {
        signupButton.backgroundColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        signupButton.layer.cornerRadius = 7
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        signupButton.tintColor = .white
    }
    
    private func configureTextButton() {
        let fullText = "Already have an account? Login"
        let attributedString = NSMutableAttributedString(string: fullText)
                
        let loginRange = (fullText as NSString).range(of: "Login")
                
        attributedString.addAttribute(.link, value: "loginAction", range: loginRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: loginRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: loginRange)

        loginTextView.attributedText = attributedString
        loginTextView.isEditable = false
        loginTextView.isScrollEnabled = false
        loginTextView.textAlignment = .center
        loginTextView.textColor = .black
        loginTextView.backgroundColor = .clear
        loginTextView.font = UIFont(name: "Red Hat Display", size: 12)
                
        loginTextView.delegate = self
    }
}
