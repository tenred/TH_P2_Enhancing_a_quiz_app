//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {

    
    var gameSound: SystemSoundID = 0
    let triviaGame = TriviaGameFlow(questionsPerRound: 2)

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        questionField.text = triviaGame.getTriviaQuestion()
        changeButtonState(triviaGame.isGameInProgress())
        
 }

    func displayScore() {
        
        changeButtonState(triviaGame.isGameInProgress())
        questionField.text = "Way to go!\nYou got \(triviaGame.getScore().CorrectQuestions) out of \(triviaGame.getScore().TotalQuestions) correct!"
        }
    
    func nextRound() {
        
        let continueGame = triviaGame.isGameInProgress()
        if continueGame {displayQuestion()} else {displayScore()}
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        
        let resultString = triviaGame.isAnswerCorrect((sender.titleLabel?.text)!).caption
        questionField.text = resultString
        loadNextRoundWithDelay(seconds: 2)
    }
    
    
    @IBAction func playAgain() {
        // Show the answer buttons

        changeButtonState(triviaGame.isGameInProgress())
        triviaGame.playAgain()
        nextRound()
    }
    
    
    func changeButtonState(gameInProgress: Bool) {
        
        switch gameInProgress {
        
        case true:
            trueButton.hidden = false
            falseButton.hidden = false
            playAgainButton.hidden = true

        case false:
            trueButton.hidden = true
            falseButton.hidden = true
            playAgainButton.hidden = false

        }
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}




