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
        
        configureView()
        configureLabels()
        configureButton()
    }
    
    @IBAction private func buttonClicked(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController ?? SecondViewController()
        present(controller, animated: true)
    }
    
    private func configureView() {
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "Image") ?? UIImage()).withAlphaComponent(0.3)
    }
    
    private func configureLabels() {
        uiLabel.font = UIFont(name: "Elephant", size: 36)
        uiLabel.text = "Welcome to uxidesign.in"
        designLabel.font = UIFont(name: "Engravers MT", size: 24)
        designLabel.text = "#1 in Design Tutorial"
        longLabel.font = UIFont(name: "Inter", size: 16)
        longLabel.text = "we are the leading online community to   teach the web and mobile design from basic to pro."
    }
    
    private func configureButton() {
        loginButton.backgroundColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        loginButton.titleLabel!.font = UIFont(name: "Red Hat Display", size: 16)
        loginButton.setTitle("Get Started", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 7
    }
}

