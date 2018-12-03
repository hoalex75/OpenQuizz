//
//  QuestionView.swift
//  OpenQuizz
//
//  Created by Alex on 03/12/2018.
//  Copyright © 2018 Alexandre Holet. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    @IBOutlet private var label : UILabel!
    @IBOutlet private var icon : UIImageView!
    var title = "" {
        didSet{
            label.text = title
        }
    }
    enum Style{
        case correct,incorrect,standard
    }
    var style : Style = .standard{
        didSet{
            setStyle(style)
        }
    }
    
    private func setStyle(_ style : Style){
        switch style{
        case .correct:
            backgroundColor = #colorLiteral(red: 0.7452508211, green: 0.9336429238, blue: 0.5910575986, alpha: 1)
            icon.image = UIImage(named: "Icon Correct")
            icon.isHidden = false
            break
        case .incorrect:
            backgroundColor = #colorLiteral(red: 1, green: 0.5007593632, blue: 0.5736216903, alpha: 1)
            icon.image = UIImage(named : "Icon Error")
            icon.isHidden = false
            break
        case .standard:
            backgroundColor = #colorLiteral(red: 0.7449215055, green: 0.7692191005, blue: 0.7904064059, alpha: 1)
            icon.image = UIImage(named: "")
            icon.isHidden = true
            break
        }
    }
}
