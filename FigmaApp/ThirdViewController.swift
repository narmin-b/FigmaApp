//
//  ThirdViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

class ThirdViewController: UIViewController, UITextViewDelegate, SecondViewControllerDelegate {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var signupTextView: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var iconClick = false
    let imageIcon = UIImageView()
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dump(users)
        configureView()
        configureLabels()
        configureEmailTextField()
        configurePasswordTextField()
        configureButton()
        configureTextButton()
        
        let registerController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController ?? SecondViewController()
        
        registerController.delegate = self
        registerController.setUserList(list: users)
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
        emailTextField.layer.borderColor = UIColor(named: "black")?.cgColor
    }s
    
    private func configureButton() {
        loginButton.backgroundColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        loginButton.layer.cornerRadius = 7
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
    }
    
    private func configureTextButton() {
        let fullText = "Don’t have an account? SignUp"
        let attributedString = NSMutableAttributedString(string: fullText)
                
        let loginRange = (fullText as NSString).range(of: "SignUp")
                
        attributedString.addAttribute(.link, value: "loginAction", range: loginRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: loginRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: loginRange)

        signupTextView.attributedText = attributedString
        signupTextView.isEditable = false
        signupTextView.isScrollEnabled = false
        signupTextView.textAlignment = .center
        signupTextView.textColor = .black
        signupTextView.backgroundColor = .clear
        signupTextView.font = UIFont(name: "Red Hat Display", size: 12)
                
        signupTextView.delegate = self
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
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            if URL.absoluteString == "loginAction" {
                let signupVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController ?? SecondViewController()
                present(signupVC, animated: true)
                //navigationController?.popViewController(animated: true)
            }
            return true
        }
    
}

extension ThirdViewController {
    func newUserAdded(newUser: User) {
        users.append(newUser)
        dump(users)
    }
    
    func isUserValid() -> Bool {
        if users.contains(where: {$0.email == emailTextField.text}) && users.contains(where: {$0.password == passwordTextField.text}) {
            return true
        }
        return false
    }
    
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        if isUserValid() {
            print("success")
        }
    }
}
