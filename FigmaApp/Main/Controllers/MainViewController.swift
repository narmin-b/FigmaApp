//
//  MainViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    
    var questionList: [Question] = []
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        generateQuestions()
    }
    
    fileprivate func generateQuestions() {
        guard let file = Bundle.main.url(forResource: "QuestionListJson", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: file) else {return}
        
        do {
            let model = try JSONDecoder().decode([Question].self, from: data)
            self.questionList = model
            print(questionList)
        } catch {
            print("Can not decode json")
            return
        }
        
        reloadCollection()
    }
    
    fileprivate func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collection.reloadData()
        }
    }
    
    fileprivate func configureView() {
        configureCollection()
    }
    
    fileprivate func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "AnswersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCollectionViewCell")
        //collection.register(UINib(nibName: "QuestionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuestionHeaderView")
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCollectionViewCell", for: indexPath) as! AnswersCollectionViewCell
        let model = questionList[indexPath.row]
        cell.delegate = self
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension MainViewController: AnswersCollectionViewCellDelegate {
    func didSelectCorrectAnswer(at indexPath: IndexPath) {
        
        currentIndex += 1
        
        if currentIndex < questionList.count {
            let nextIndexPath = IndexPath(item: currentIndex, section: 0)
            collection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            print("End of questions reached.")
            currentIndex = -1
        }
    }
}
