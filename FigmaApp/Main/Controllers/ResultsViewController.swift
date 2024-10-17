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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader()
        configureLeaderboard()
        
        configureName()
    }
    
    fileprivate func configureHeader() {
        headerLabel.text = "Leaderboard"
        headerLabel.font = UIFont(name: "Baloo 2", size: 22)
    }
    
    fileprivate func configureLeaderboard() {
        leaderImage.image = UIImage(named: "person")
        leaderImage.layer.masksToBounds = true
        leaderImage.layer.cornerRadius = leaderImage.frame.size.width / 2
    }

    fileprivate func configureName() {
        let name = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        leaderName.text = name
        leaderName.font = UIFont(name: "Baloo 2", size: 12)
    }
    
    fileprivate func configureLeaderResult() {
        
    }
}

extension ResultsViewController: AnswersCollectionViewCellDelegate {
    func changeToNextQuestion(at indexPath: IndexPath) {
        
    }
    
    func correctAnswers(correct: Int) {
        leaderResult.text = "\(correct)/4"
    }
    
}
