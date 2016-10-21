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
    var indexOfSelectedQuestion = 0
    var questionHistory: [Int] = []

    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        
    }
    
    func getTriviaQuestion() -> String{
        
        var questionAskedBefore: Bool

        repeat {
            
            questionAskedBefore = false
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestion.getTotalQuestionCount())
            
            print("Catalogue: \(questionHistory) | Index: \(indexOfSelectedQuestion)")
            
            if questionHistory != [] {
               for qn in questionHistory{
                    if qn == indexOfSelectedQuestion {
                        print("Duplicate Found")
                        questionAskedBefore = true
                    }
                }
            }
            
        } while questionAskedBefore == true
        
        questionHistory.insert(indexOfSelectedQuestion, atIndex: questionHistory.endIndex)
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
    
    func returnQuestionOptions(OptionNo: Int) -> String {
        
        let arrAnswerOptions = triviaQuestion.getAnswerOptions(atIndex: indexOfSelectedQuestion)
        return arrAnswerOptions[OptionNo]
    }
    
    func playAgain() {
        
        questionsAsked = 0
        correctQuestions = 0
        questionHistory.removeAll()
    }
}

