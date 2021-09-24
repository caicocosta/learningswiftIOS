//
//  ResultViewController.swift
//  SwiftQuiz
//
//  Created by Caico Saler Oliveira Costa on 23/09/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lbAnswered: UILabel!
    @IBOutlet weak var lbCorrect: UILabel!
    @IBOutlet weak var lbWrong: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    
    var totalCorrectAnswer = 0
    var totalAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbAnswered.text = "Perguntas respondidas: \(totalAnswer)"
        lbCorrect.text = "Perguntas corretas: \(totalCorrectAnswer)"
        lbWrong.text = "Perguntas erradas: \(totalAnswer - totalCorrectAnswer)"
        let score = totalCorrectAnswer*100/totalAnswer
        lbScore.text = "\(score)%"
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
