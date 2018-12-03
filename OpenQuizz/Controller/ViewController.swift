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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
}

