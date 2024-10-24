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
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureBackground()
        configureButton()
    }
    
    fileprivate func configureBackground() {
        bgView.backgroundColor = .background
        let img = UIImageView(image: UIImage(resource: .init(name: "backgroundImage", bundle: Bundle.main)))
        img.alpha = 0.3
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false

        bgView.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            img.widthAnchor.constraint(equalTo: bgView.widthAnchor),
            img.heightAnchor.constraint(equalTo: bgView.heightAnchor)
        ])
    }
    
    fileprivate func configureButton() {
        logoutButton.tintColor = .logoutButton
        logoutButton.setAttributedTitle(NSAttributedString(string: "Log out", attributes: [.font: UIFont(name: "Baloo2-Bold", size: 16) as Any]), for: .normal)
        logoutButton.titleLabel?.textColor = .white
        logoutButton.layer.cornerRadius = 20
    }
    
    fileprivate func configureView() {
        let name = UserDefaults.standard.string(forKey: "name") ?? ""
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        
        nameLabel.text = name
        nameLabel.textColor = .white
        emailLabel.text = email
        emailLabel.textColor = .white
        
        profileImage.image = UIImage(named: "person")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
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
