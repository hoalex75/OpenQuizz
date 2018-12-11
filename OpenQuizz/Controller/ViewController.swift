//
//  ViewController.swift
//  OpenQuizz
//
//  Created by Alex on 03/12/2018.
//  Copyright © 2018 Alexandre Holet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
        
        startNewGame()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView(_:)))
        questionView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func questionsLoaded(){
        activityIndicator.isHidden = true
        button.isHidden = false
        
        questionView.title = game.currentQuestion.title
    }

    @IBAction func didTapNewGameButton() {
        startNewGame()
    }
    
    private func startNewGame(){
        activityIndicator.isHidden = false
        button.isHidden = true
        questionView.style = .standard
        questionView.title = "Loading..."
        score.text = "0 / 10"
        game.refresh()
    }
    
    @objc func dragQuestionView(_ sender: UIPanGestureRecognizer){
        if game.state == .ongoing{
            switch sender.state {
            case .began, .changed:
                transformQuestionView(sender)
            case .ended, .cancelled:
                answerQuestion()
            default:
                break
            }
        }
    }
    
    private func transformQuestionView(_ gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: questionView)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        let widthScreen = UIScreen.main.bounds.width
        let translationPercent = translation.x / (widthScreen/2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        questionView.transform = translationTransform.concatenating(rotationTransform)
        
        if translation.x < 0{
            questionView.style = .incorrect
        } else {
            questionView.style = .correct
        }
    }
    
    private func answerQuestion(){
        switch questionView.style {
        case .correct:
            game.answerCurrentQuestion(with: true)
        case .incorrect:
            game.answerCurrentQuestion(with: false)
        default:
            break
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let transformation : CGAffineTransform
        if questionView.style == .correct {
            transformation = CGAffineTransform(translationX: screenWidth, y: 0)
        } else {
            transformation = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.questionView.transform = transformation
        }) { (success) in
            if success {
                self.showQuestionView()
            }
        }
        
        score.text="\(game.score) / 10"
        
        
        
        
    }
    
    private func showQuestionView(){
        questionView.transform = .identity
        questionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        questionView.style = .standard
        
        switch game.state {
        case .ongoing:
            questionView.title = game.currentQuestion.title
        default:
            questionView.title = "Game Over"
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.questionView.transform = .identity
        }, completion: nil)
    }
}

