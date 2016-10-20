//
//  TriviaGameFlow.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 20/10/16.
//

import Foundation
import GameKit

class TriviaGameFlow {
    
    let questionsPerRound: Int
    let triviaQuestion = QuestionData()
    
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0

    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        
    }
    
    func getTriviaQuestion() -> String{
    
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestion.getTotalQuestionCount())
        return triviaQuestion.getQuestion(atIndex: indexOfSelectedQuestion)
    }
    
    
    func getScore() -> (CorrectQuestions: Int, TotalQuestions: Int){
    
        return (correctQuestions, questionsPerRound)
    }
    
    func isAnswerCorrect(submittedAnswer: String) -> (result: Bool, caption: String) {
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = triviaQuestion.getAnswer(atIndex: indexOfSelectedQuestion)
        
        if submittedAnswer == correctAnswer {
            correctQuestions += 1
            return (true, "Correct Answer")
            
        } else {
            return (false, "Sorry, Bad Luck")
        }
        
        //loadNextRoundWithDelay(seconds: 2)
    }
    
    func isGameInProgress() -> Bool {
        
        if questionsAsked == questionsPerRound {
            // Game is over
            return false
        } else {
            // Continue game
            return true
        }
    }
    
    func playAgain() {
        questionsAsked = 0
        correctQuestions = 0
    }
}

