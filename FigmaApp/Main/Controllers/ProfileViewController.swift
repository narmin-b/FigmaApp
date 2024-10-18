//
//  ProfileViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 18.10.24.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    fileprivate func configureView() {
        let name = UserDefaults.standard.string(forKey: "name") ?? ""
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        
        nameLabel.text = name
        emailLabel.text = email
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToLogin()
        }
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.synchronize()
    }
}
