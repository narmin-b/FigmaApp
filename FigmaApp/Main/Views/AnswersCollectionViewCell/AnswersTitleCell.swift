//
//  AnswersTitleCell.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 14.10.24.
//

import UIKit

class AnswersTitleCell: UICollectionViewCell {
    @IBOutlet weak var answerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(model: Answer) {
        answerLabel.text = model.title
        answerLabel.layer.cornerRadius = 20
        answerLabel.layer.masksToBounds = true
        answerLabel.font = UIFont(name: "Baloo 2", size: 20)
    }
}


    
