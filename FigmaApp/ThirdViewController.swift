//
//  ThirdViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 01.10.24.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var signupTextView: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Hey, welcome   Back!"
        welcomeLabel.font = UIFont(name: "Elephant", size: 36)
        continueLabel.text = "continue with email"
        continueLabel.font = UIFont(name: "Inter", size: 15)
        
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
        
        loginButton.tintColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        loginButton.layer.cornerRadius = 7
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
    }
    
}
