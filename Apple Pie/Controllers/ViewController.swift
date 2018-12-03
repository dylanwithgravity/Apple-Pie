//
//  ViewController.swift
//  Apple Pie
//
//  Created by Dylan Williamson on 12/2/18.
//  Copyright © 2018 Dylan Williamson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["pizza", "hotel", "glorious", "incandescent", "bug"]
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    var currentGame: Game!
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
}

