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

    let triviaGame = TriviaGameFlow(questionsPerRound: 10)
    var gameAudio = AudioControl()
    let theTimer = CountdownTimer(timerInSeconds: 15)
    var lightningModeEnabled = false
    var timerInterval: NSTimer?
    
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var timerField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet var arrOptionButtons: [UIButton]!
    
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var lightningModeButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        gameAudio.playStartSound()
        changeUIState("newGame", selectedButton: nil)
        displayQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        //Description: displays individual question from triviaGame class
        
        //Checks if user has selected Lightning Mode.
        //If so, display counter and commence.
        if lightningModeEnabled{
            displayTimerCountdown(timerInterval!)
            lightningMode()
        }
        
        questionField.text = triviaGame.getTriviaQuestion()
        changeUIState("nextRound", selectedButton: nil)
        displayButtonOptions()
        
 }

    func displayButtonOptions(){
        //Description: Get the different answer option and display on the option UIButtons.
        
        var optionIndex = 0
        
        //Loop through Outlet Collection of option buttons arrOptionButtons
        for button in arrOptionButtons{
            button.setTitle(triviaGame.questionOptions(optionIndex), forState: .Normal)
            optionIndex += 1
        }
    }
    
    func displayScore() {
        //Description: On completion of the game, display the overall score to the user including changeing the UI state and Game Audio.
        
        changeUIState("EndOfGame", selectedButton: nil)
        questionField.text = "Way to go!\nYou got \(triviaGame.getScore().CorrectQuestions) out of \(triviaGame.getScore().TotalQuestions) correct!"
        gameAudio.playFinishGameSound()
    }
    
    
    func displayCorrectAnswer() {
        //Description: If the user submits a wrong answer, highlight the button that displays the correct answer.
        
        let correctAnswerAtIndex = triviaGame.correctAnswerAtIndex()
        
        for button in arrOptionButtons {
            if correctAnswerAtIndex == Int(button.accessibilityIdentifier!)! {
                changeUIState("showCorrect", selectedButton: button)
            }
        }
    }
    

    @IBAction func nextRound() {
        
        //Description: Checks if the game is still in play by comparing the number of questions asked with the total question in round.
        //Determine is to proceed to next question or end game.
        
        let continueGame = triviaGame.isGameInPlay()
        
        if continueGame {
            displayQuestion()
        } else {
            displayScore()
        }
    }
    
    @IBAction func lightningMode() {
        //Description: Triggers lightning mode when triggered.
        //NSTimer interval triggers displayTimerCountdown
        
        lightningModeEnabled = true
        timerField.text = String("Lightning Mode is ON")
        changeUIState("timerOn", selectedButton: nil)

        timerInterval = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.displayTimerCountdown(_:)), userInfo: nil, repeats: true)

    }
    
    func displayTimerCountdown(timer: NSTimer){
        //Description: interates the countdown timer;
        // Timer behaviour is managed by class CountdownTimer
        
        if theTimer.isActive() {
            timerField.text = String("Count down: \(theTimer.countingDown())")

        } else {
            timerField.text = "Out of Time"
            theTimer.resetTime()
            timerInterval!.invalidate()
            checkAnswer(nil)
        }
    }
    
    
    @IBAction func checkAnswer(sender: UIButton?) {
        //Description: Calls TriviaGameFlow class to confirm if submitted answer is correct.
        //Play Audio depending on Correct or Incorrect Answer.
        
        let submittedAnswer = sender?.titleLabel!.text
        
        changeUIState("questionAnswered", selectedButton: sender)
        
        //Check is lightning mode is on.
        //If so, stop timer.
        if lightningModeEnabled{
            timerInterval!.invalidate()
            theTimer.resetTime()
        }

        
        if submittedAnswer != nil && triviaGame.isAnswerCorrect(submittedAnswer) {
            //Answer is Correct
            resultField.text = "Correct."
            changeUIState("correct", selectedButton: sender)
            gameAudio.playCorrectAnswerSound()
            
        } else {
            //Answer is wrong
            resultField.text = "Sorry, that's not it."
            changeUIState("wrong", selectedButton: sender)
            displayCorrectAnswer()
            gameAudio.playWrongAnswerSound()
            
        }
    }

    
    @IBAction func playAgain() {
        //Description: Play again button will remain hidden until game is ended.
        //When triggered game will re-initiate and play again.
        changeUIState("newGame", selectedButton: playAgainButton)
        changeUIState("timerOff", selectedButton: playAgainButton)

        triviaGame.playAgain()
        theTimer.resetLightningMode()
        lightningModeEnabled = false
        nextRound()
        
    }
    
    func changeUIState(gameState: String, selectedButton: UIButton?) {
        //Description: Consolidate all various UI state changes into a method.
        
        //Default color scheme's
        let defaultButtonBGColor = UIColor.init(red: 12/255, green: 120/255, blue: 148/255, alpha: 1.0)
        let correctButtonBGColor = UIColor.greenColor()
        let wrongButtonBGColor = UIColor.redColor()
        let answerButtonBGColor = UIColor.greenColor()
        let defaultTextColor = UIColor.whiteColor()
        let wrongAnswerTextColor = UIColor.orangeColor()
        let correctAnswerTextColor = UIColor.greenColor()
        
        
        //Switch statement to change UI based on events within the trivia game.
        
        switch gameState {
            
        case "newGame":
            //UI attributes for a New Game.
            changeOptionButtons(false, enabled: true, alpha: 1.0, txtcolor: defaultTextColor, bgcolor: defaultButtonBGColor, corner: 7)
            
            playAgainButton.layer.cornerRadius = 7
            nextQuestionButton.layer.cornerRadius = 7
            
            playAgainButton.hidden = true
            nextQuestionButton.hidden = true
            
            resultField.hidden = true
            timerField.hidden = true
            
            
        case "nextRound":
            //UI attributes for the next question within a game
            changeOptionButtons(false, enabled: true, alpha: 1.0, txtcolor: nil, bgcolor: defaultButtonBGColor, corner: nil)
            
            resultField.hidden = true
            nextQuestionButton.hidden = true

            
        case "questionAnswered":
            //UI Attributes when an option button/answer has been submitted.
            changeOptionButtons(false, enabled: false, alpha: 0.3, txtcolor: nil, bgcolor: nil, corner: nil)
            selectedButton?.enabled = true
            selectedButton?.alpha = 1.0
            
            resultField.hidden = false
            nextQuestionButton.hidden = false
            //lightningModeButton.enabled = false
            
            
        case "correct":
            //UI Attribute when a correct answer has been submitted.
            selectedButton?.backgroundColor = correctButtonBGColor
            resultField.textColor = correctAnswerTextColor
            
        case "wrong":
            // UI Attribute when a wrong answer has been submitted.
            selectedButton?.backgroundColor = wrongButtonBGColor
            resultField.textColor = wrongAnswerTextColor
            
        case "showCorrect":
            //UI Attribute to show the correct answer if a wrong answer has been selected.
            selectedButton?.alpha = 1.0
            selectedButton?.backgroundColor = answerButtonBGColor
            selectedButton?.setTitleColor(defaultTextColor, forState: .Normal)
            
        case "timerOn":
            //UI Attribute when Lightning mode has been selected.
            timerField.hidden = false
            lightningModeButton.enabled = false
            
            
        case "timerOff":
            //UI Attribute when Lightning mode has been selected.
            timerField.hidden = true
            lightningModeButton.enabled = true
            
        case "EndOfGame":
            //UI Attribute when the game has finished all question.
            
            changeOptionButtons(true, enabled: false, alpha: 0.0, txtcolor: nil, bgcolor: nil, corner: nil)
            playAgainButton.hidden = false
            resultField.hidden = true
            timerField.hidden = true
            nextQuestionButton.hidden = true
            
        default:
            break
        }
        
    }
    
    func changeOptionButtons(hidden: Bool, enabled: Bool, alpha: CGFloat, txtcolor: UIColor?, bgcolor: UIColor?, corner: CGFloat?){
        //Description: Rotates through the array of OptionButtons and applies UI Changes.
        
        for button in arrOptionButtons{
            button.hidden = hidden
            button.enabled = enabled
            button.alpha = alpha
            if (bgcolor != nil) {button.backgroundColor = bgcolor!}
            if (corner != nil){button.layer.cornerRadius = corner!}
            if (txtcolor != nil){button.setTitleColor(txtcolor, forState: .Normal)}
        }
    }
    
    
} //End of ViewController.




