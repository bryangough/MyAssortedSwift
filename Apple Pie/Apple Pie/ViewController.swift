//
//  ViewController.swift
//  Apple Pie
//
//  Created by Bryan Gough on 2017-06-01.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var currentGame: Game!
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
   
    func updateGameState(){
        if currentGame.incorrectMovesRemaining <= 0{
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }else
        {
            updateUI()
        }
    }
    func updateUI() {
        var letters = [String]()
        letters = currentGame.formattedWord.characters.map{String($0)}
        /*for letter in currentGame.formattedWord.characters{
            letters.append(String(letter))
        }*/
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        //print("\(currentGame.incorrectMovesRemaining)");
        //treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

