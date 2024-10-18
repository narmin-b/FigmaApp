//
//  MainViewController.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import UIKit



class MainViewController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var questionNum: UILabel!
    
    var questionList: [Question] = []
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        generateQuestions()
        questionCount()
        UserDefaults.standard.setValue(2, forKey: "loginType")
    }
    
    fileprivate func questionCount() {
        questionNum.text = "1/\(questionList.count)"
        questionNum.font = UIFont(name: "Baloo 2", size: 18)
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
        view.backgroundColor = UIColor(red: 0.9373, green: 0.9412, blue: 0.9529, alpha: 1.0)
    }
    
    fileprivate func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "AnswersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCollectionViewCell")
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
        return .init(width: 347, height: collectionView.frame.height)
    }
}

extension MainViewController: AnswersCollectionViewCellDelegate {
    func correctAnswers(correct: Int) {
        
    }
    
    func noOfQuestionsReached(at indexPath: IndexPath) {
        questionNum.text = "\(currentIndex + 1)/\(questionList.count)"
        questionNum.font = UIFont(name: "Baloo 2", size: 18)
    }
    
    func changeToNextQuestion(at indexPath: IndexPath) {
                
        currentIndex += 1

        if currentIndex < questionList.count {
            let nextIndexPath = IndexPath(item: currentIndex, section: 0)
            collection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            noOfQuestionsReached(at: nextIndexPath)
        } else {
            print("End of questions reached.")
            currentIndex = 0
            let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController ?? ResultsViewController()
            navigationController?.pushViewController(controller, animated: true)
            noOfQuestionsReached(at: IndexPath(item: 1, section: 0))
            collection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
