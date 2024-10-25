//
//  AnswersCollectionViewCell.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

protocol AnswersCollectionViewCellDelegate: AnyObject {
    func changeToNextQuestion(at indexPath: IndexPath)
}

class AnswersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collection: UICollectionView!
    private var question: Question?
    private var flag = false
    
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
        cell.configureCell(model: answer, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 347, height: 53)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 347, height: 325)
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
        
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let answer = question?.answer[indexPath.row] else {return}
//        let myCell = collection.cellForItem(at: indexPath) as! AnswersTitleCell
//        if !flag {
//            flag = true
//            if answer.correct {
//                myCell.answerButton.backgroundColor = .correctSelection
////                myCell.answerButton.tintColor = .correctCellText
////                myCell.answerButton.setAttributedTitle(NSAttributedString(string: myCell.answerButton.title(for: .normal) ?? "", attributes: [.foregroundColor: UIColor.correctCellText]), for: .normal)
////                myCell.answerButton.setTitleColor(.correctCellText, for: .normal)
//                myCell.answerButton.titleLabel?.textColor = .correctCellText
//
//                // Optionally update the attributed title if you want to use custom styles
//                if let currentTitle = myCell.answerButton.title(for: .normal) {
//                    let attributedTitle = NSAttributedString(string: currentTitle, attributes: [.foregroundColor: UIColor.correctCellText])
//                    myCell.answerButton.setAttributedTitle(attributedTitle, for: .normal)
//                }
//                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "correctNum") + 1, forKey: "correctNum")
//            }
//            else {
//                myCell.answerButton.backgroundColor = .wrongSelection
//                myCell.answerButton.tintColor = .wrongCellText
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
//                delegate?.changeToNextQuestion(at: indexPath)
//                flag = false
//                myCell.answerButton.backgroundColor = .white
//                myCell.answerButton.tintColor = .black
//            }
//        }
//    }
    
}

extension AnswersCollectionViewCell: AnswersTitleCellDelegate {
    
    func didSelectAnswer(_ answer: AnswersTitleCellProtocol, at indexPath: IndexPath) {
        guard let myCell = collection.cellForItem(at: indexPath) as? AnswersTitleCell else { return }
        
        if !flag {
            flag = true
            myCell.answerButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            if answer.correctBool {
                myCell.answerButton.backgroundColor = .correctSelection
                myCell.answerButton.tintColor = .correctCellText
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "correctNum") + 1, forKey: "correctNum")
            } else {
                myCell.answerButton.backgroundColor = .wrongSelection
                myCell.answerButton.tintColor = .wrongCellText
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.delegate?.changeToNextQuestion(at: indexPath)
                myCell.answerButton.backgroundColor = .white
                myCell.answerButton.tintColor = .black
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.flag = false
                }
            }
        }
    }
}
