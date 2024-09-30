//
//  ViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 30.09.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiLabel: UILabel!
    @IBOutlet weak var designLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiLabel.font = UIFont(name: "Elephant", size: 36)
        uiLabel.text = "Welcome to uxidesign.in"
        designLabel.font = UIFont(name: "Engravers MT", size: 24)
        designLabel.text = "#1 in Design Tutorial"
        longLabel.font = UIFont(name: "Inter", size: 16)
        longLabel.text = "we are the leading online community to   teach the web and mobile design from basic to pro."
        loginButton.tintColor = UIColor(red: 0.3882, green: 0.3686, blue: 0.3686, alpha: 1)
        loginButton.setTitle("Get Started", for: .normal)
        //fontTester()
    }
    
    func fontTester() {
                for family: String in UIFont.familyNames
                       {
                           print(family)
                           for names: String in UIFont.fontNames(forFamilyName: family)
                           {
                               print("== \(names)")
                           }
                       }
    }
}

