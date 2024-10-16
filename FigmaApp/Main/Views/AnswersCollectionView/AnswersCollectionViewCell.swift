//
//  AnswersCollectionViewCell.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

protocol AnswersCollectionViewCellDelegate: AnyObject {
//    func didSelectCorrectAnswer(at indexPath: IndexPath)
//    func didSelectIncorrectAnswer(at indexPath: IndexPath)
    func changeToNextQuestion(at indexPath: IndexPath)
    func noOFQuestionsReached(at indexPath: IndexPath)
}

class AnswersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collection: UICollectionView!
    private var question: Question?
    
    weak var delegate: AnswersCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
    }

    fileprivate func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "AnswersTitleCell", bundle: nil), forCellWithReuseIdentifier: "AnswersTitleCell")
        collection.register(UINib(nibName: "QuestionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuestionHeaderView")
    }
    
    func configureCell(model: Question) {
        question = model
        reloadCollection()
    }
    
    fileprivate func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collection.reloadData()
        }
    }
}

extension AnswersCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        question?.answer.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersTitleCell", for: indexPath) as! AnswersTitleCell
        guard let answer = question?.answer[indexPath.row] else {return UICollectionViewCell()}
        cell.configureCell(model: answer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 383, height: 53)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 383, height: 325)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "QuestionHeaderView", for: indexPath) as! QuestionHeaderView
            guard let model = question else {return UICollectionReusableView()}
            delegate?.noOFQuestionsReached(at: indexPath)
                header.configureView(model: model)
                return header
            default:
                return UICollectionReusableView()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let answer = question?.answer[indexPath.row] else {return}
        if answer.correct {
            let myCell = collection.cellForItem(at: indexPath) as! AnswersTitleCell 
            myCell.answerLabel.backgroundColor = UIColor(red: 0.6706, green: 0.8196, blue: 0.7765, alpha: 1.0)
            myCell.answerLabel.textColor = UIColor(red: 0, green: 0.2745, blue: 0.2627, alpha: 1.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                delegate?.changeToNextQuestion(at: indexPath)
                myCell.answerLabel.backgroundColor = .white
                myCell.answerLabel.textColor = .black
            }
        }
        else {
            let myCell = collection.cellForItem(at: indexPath) as! AnswersTitleCell
            myCell.answerLabel.backgroundColor = UIColor(red: 0.6706, green: 0, blue: 0, alpha: 0.5)
            myCell.answerLabel.textColor = UIColor(red: 0.6706, green: 0, blue: 0, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                myCell.answerLabel.backgroundColor = .white
                myCell.answerLabel.textColor = .black
            }
        }
        print(#function, answer, indexPath.row)
    }
    
}
