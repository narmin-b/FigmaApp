//
//  AnswersCollectionViewCell.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

protocol AnswersCollectionViewCellDelegate: AnyObject {
    func didSelectCorrectAnswer(at indexPath: IndexPath)
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
        return .init(width: collectionView.frame.width/2 - 12, height: collectionView.frame.height/4 - 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "QuestionHeaderView", for: indexPath) as! QuestionHeaderView
            guard let model = question else {return UICollectionReusableView()}
                header.configureView(model: model)
                return header
            default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let answer = question?.answer[indexPath.row] else {return}
        if answer.correct {
            print(indexPath)
            delegate?.didSelectCorrectAnswer(at: indexPath)
//            let nextIndexPath = IndexPath(item: indexPath.row + 1, section: 0)
//            collection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
        print(#function, answer, indexPath.row)
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let answer = question?.answer[indexPath.row] else {
//            print("Failed to retrieve answer for index: \(indexPath.row)")
//            return
//        }
//        
//        print("Selected answer: \(answer.title), Correct: \(answer.correct)")
//        
//        if answer.correct {
//            let nextItem = indexPath.row + 1
//            
//            // Check if next item exists within bounds
//            if nextItem < 3 {
//                let nextIndexPath = IndexPath(item: nextItem, section: 0)
//                print("Scrolling to next question at index: \(nextIndexPath.row)")
//                collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
//            } else {
//                print("End of questions reached.")
//                // Handle end of quiz logic
//            }
//        } else {
//            print("Selected answer is incorrect.")
//            // Optional: Show feedback for incorrect answers
//        }
//    }
    
}
