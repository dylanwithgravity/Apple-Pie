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
    var gamePoints = 0 {
        didSet {
            newRound()
        }
    }
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
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
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, points: gamePoints, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            correctWordLabel.text = "Game Over!"
        }
    }
    
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateGameStatus() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            gamePoints += 5
        } else {
            updateUI()
        }
    
    }
    
    func updateUI() {
        var letters = [String]()
        letters = currentGame.formattedWord.map({ String($0)})
        let wordWithSpacing = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses), Points: \(gamePoints)"
        correctWordLabel.text = wordWithSpacing
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameStatus()
    }
    
}

