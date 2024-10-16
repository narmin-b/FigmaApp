//
//  ViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 30.09.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var uiLabel: UILabel!
    @IBOutlet weak var designLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(0, forKey: "loginType")
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
        configureButton()
    }
    
    private func configureLabels() {
        uiLabel.font = UIFont(name: "Elephant", size: 36)
        uiLabel.text = "Welcome to uxidesign.in"
        designLabel.font = UIFont(name: "Engravers MT", size: 24)
        designLabel.text = "#1 in Design Tutorial"
        longLabel.font = UIFont(name: "Inter", size: 16)
        longLabel.text = "we are the leading online community to     teach the web and mobile design from basic       to pro."
    }
    
    private func configureButton() {
        loginButton.backgroundColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        loginButton.setTitle("Get Started", for: .normal)
        loginButton.titleLabel?.textColor = .white
        loginButton.layer.cornerRadius = 7
        
        loginButton.addTarget(self, action: #selector (loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        let controller = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController ?? ThirdViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

