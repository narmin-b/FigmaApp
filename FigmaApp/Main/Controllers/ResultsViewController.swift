//
//  ResultsViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 17.10.24.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var leaderResult: UILabel!
    @IBOutlet weak var leaderName: UILabel!
    @IBOutlet weak var leaderImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc fileprivate func resetQuiz() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func navigationBarSet() {
        UIBarButtonItem.appearance().tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector (resetQuiz))
    }
    
    fileprivate func configureView() {
        configureHeader()
        configureLeaderboard()
        configureName()
        navigationBarSet()
        configureLeaderResult()
        bgView.backgroundColor = .bgColorr
    }
    
    fileprivate func configureHeader() {
        headerLabel.text = "Leaderboard"
        headerLabel.font = UIFont(name: "Baloo 2", size: 22)
        headerLabel.textColor = .white
    }
    
    fileprivate func configureLeaderboard() {
        leaderImage.image = UIImage(named: "person")
        leaderImage.layer.masksToBounds = true
        leaderImage.layer.cornerRadius = leaderImage.frame.size.width / 2
    }

    fileprivate func configureName() {
        let name = UserDefaults.standard.string(forKey: "name") ?? "Guest"
        leaderName.text = name
        leaderName.font = UIFont(name: "Baloo2-Bold", size: 20)
        leaderName.textColor = .white
    }
    
    fileprivate func configureLeaderResult() {
        let num = UserDefaults.standard.integer(forKey: "correctNum")
        leaderResult.text = "\(num)/4"
        leaderResult.font = UIFont(name: "Baloo 2", size: 16)
        leaderResult.textColor = .white
    }
    
    
}


