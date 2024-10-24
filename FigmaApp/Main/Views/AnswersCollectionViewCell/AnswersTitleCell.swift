//
//  AnswersTitleCell.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 14.10.24.
//

import UIKit

protocol AnswersTitleCellDelegate: AnyObject {
    func didSelectAnswer(_ answer: Answer, at indexPath: IndexPath)
}

class AnswersTitleCell: UICollectionViewCell {
    @IBOutlet weak var answerButton: UIButton!
    var delegate: AnswersTitleCellDelegate?
    private var answer: Answer?
    private var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(model: Answer, indexPath: IndexPath) {
        self.answer = model
        self.indexPath = indexPath
        answerButton.layer.masksToBounds = true
        answerButton.setAttributedTitle(NSAttributedString(string: model.title, attributes: [.font: UIFont(name: "Baloo 2", size: 20) ?? UIFont()]), for: .normal)
        answerButton.backgroundColor = .white
        answerButton.layer.cornerRadius = 20
        answerButton.tintColor = .black
        answerButton.addTarget(self, action: #selector(madeSelection), for: .touchUpInside)
        
        answerButton.setImage(UIImage(systemName: "circle"), for: .normal)
        answerButton.semanticContentAttribute = .forceRightToLeft
        answerButton.contentHorizontalAlignment = .fill
    
    }
    
    @objc func madeSelection() {
        guard let answer = self.answer, let indexPath = self.indexPath else { return }
        delegate?.didSelectAnswer(answer, at: indexPath) 
    }
}


    
