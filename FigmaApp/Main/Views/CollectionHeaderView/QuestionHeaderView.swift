//
//  QuestionHeaderView.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

class QuestionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(model: Question) {
        
        questionLabel.text = model.title
        questionLabel.layer.cornerRadius = 20
        questionLabel.layer.masksToBounds = true
        
//        questionLabel.layer.shadowOpacity = 100
//        questionLabel.layer.shadowColor = UIColor.black.cgColor
//        questionLabel.layer.shadowRadius = 10
    }
}

extension QuestionHeaderView: AnswersCollectionViewCellDelegate {
    func changeToNextQuestion(at indexPath: IndexPath) {
        return
    }
    
    func noOFQuestionsReached(at indexPath: IndexPath) {
        questionNum.text = "\(indexPath.row + 1)"
    }
    
    
}
