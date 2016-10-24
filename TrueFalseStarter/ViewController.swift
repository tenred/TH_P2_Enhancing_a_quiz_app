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
    let triviaGame = TriviaGameFlow(questionsPerRound: 5)
    var gameAudio = AudioControl()
    

    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        gameAudio.playStartSound()
        
        changeUIState("newGame", buttonPressed: nil)
        displayQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        questionField.text = triviaGame.getTriviaQuestion()
        //changeButtonState(triviaGame.isGameInProgress())
        changeUIState("nextRound", buttonPressed: nil)
        displayButtonOptions()
 }

    func displayButtonOptions(){
        
        option1.setTitle(triviaGame.questionOptions(0), forState: .Normal)
        option2.setTitle(triviaGame.questionOptions(1), forState: .Normal)
        option3.setTitle(triviaGame.questionOptions(2), forState: .Normal)
        option4.setTitle(triviaGame.questionOptions(3), forState: .Normal)

    }
    
    func displayScore() {
        
        changeUIState("EndOfGame", buttonPressed: nil)
        questionField.text = "Way to go!\nYou got \(triviaGame.getScore().CorrectQuestions) out of \(triviaGame.getScore().TotalQuestions) correct!"
        }
    
    func changeUIState(gameState: String, buttonPressed: UIButton?) {
        
        switch gameState {
            
        case "newGame":
            option1.hidden = false
            option2.hidden = false
            option3.hidden = false
            option4.hidden = false
            
            option1.layer.cornerRadius = 7
            option2.layer.cornerRadius = 7
            option3.layer.cornerRadius = 7
            option4.layer.cornerRadius = 7
            playAgainButton.layer.cornerRadius = 7
            nextQuestionButton.layer.cornerRadius = 7
            
            playAgainButton.hidden = true
            resultField.hidden = true
            nextQuestionButton.hidden = true
            
        case "nextRound":
            option1.enabled = true
            option2.enabled = true
            option3.enabled = true
            option4.enabled = true

            option1.alpha = 1.0
            option2.alpha = 1.0
            option3.alpha = 1.0
            option4.alpha = 1.0
            
            resultField.hidden = true
            nextQuestionButton.hidden = true
            
        case "questionAnswered":
            option1.enabled = false
            option2.enabled = false
            option3.enabled = false
            option4.enabled = false
            
            option1.alpha = 0.3
            option2.alpha = 0.3
            option3.alpha = 0.3
            option4.alpha = 0.3
            
            buttonPressed?.enabled = true
            buttonPressed?.alpha = 1.0

            resultField.hidden = false
            nextQuestionButton.hidden = false
            
        case "EndOfGame":
            option1.hidden = true
            option2.hidden = true
            option3.hidden = true
            option4.hidden = true
            playAgainButton.hidden = false
            resultField.hidden = true
            nextQuestionButton.hidden = true
            
        default:
            break
        }
    }
    
    @IBAction func nextRound() {
        
        let continueGame = triviaGame.isGameInPlay()
        if continueGame {
            displayQuestion()
        } else {displayScore()}
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        
        changeUIState("questionAnswered", buttonPressed: sender)
        
        if triviaGame.isAnswerCorrect((sender.titleLabel?.text)!) {
            resultField.text = "Correct."
            resultField.textColor = UIColor.greenColor()
        } else {
            resultField.text = "Sorry, that't not it."
            resultField.textColor = UIColor.orangeColor()
        }
        
        //loadNextRoundWithDelay(seconds: 2)
    }
    
    
    @IBAction func playAgain() {
        // Show the answer buttons

        changeUIState("newGame", buttonPressed: playAgainButton)
        triviaGame.playAgain()
        nextRound()
    }
    
    

/*
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
 */
    
}




