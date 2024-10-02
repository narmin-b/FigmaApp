//
//  SecondViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

class SecondViewController: UIViewController, UITextViewDelegate {
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
    var myString:NSString = "Already have an account? Login"
    var myMutableString = NSMutableAttributedString()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLabel.text = "Create Account"
        createLabel.font = UIFont(name: "Elephant", size: 36)
        textLabel.text = "Find the things that you love!"
        textLabel.font = UIFont(name: "Inter", size: 15)
        
        fullnameLabel.text = "Full Name"
        fullnameLabel.font = UIFont(name: "Red Hat Display", size: 10)
        fullnameTextField.font = UIFont(name: "Red Hat Display", size: 10)
        fullnameTextField.layer.cornerRadius = 7
        fullnameTextField.layer.borderWidth = 1
        fullnameTextField.layer.borderColor = UIColor(named: "black")?.cgColor
        
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.font = UIFont(name: "Red Hat Display", size: 10)
        emailTextField.layer.cornerRadius = 7
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "black")?.cgColor
        
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.font = UIFont(name: "Red Hat Display", size: 10)
        passwordTextField.layer.cornerRadius = 7
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "black")?.cgColor
        
        signupButton.tintColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        signupButton.layer.cornerRadius = 7
        signupButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        
        //loginLabel.text = "Already have an account? Login"
        //loginLabel.font = UIFont(name: "Red Hat Display", size: 12)
        
        
        
//        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Red Hat Display", size: 12)!])
//        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:25,length:5))
//            // set label Attribute
//        loginLabel.attributedText = myMutableString
        
        
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
                
                loginTextView.delegate = self
    }

    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            if URL.absoluteString == "loginAction" {
                let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController ?? ThirdViewController()
                present(loginVC, animated: true)
            }
            return true
        }
}
