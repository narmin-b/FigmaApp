//
//  QuestionHeaderView.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

class QuestionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var questionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(model: Question) {
        
        questionLabel.text = model.title
        questionLabel.layer.cornerRadius = 20
        questionLabel.layer.masksToBounds = true
    }
}
