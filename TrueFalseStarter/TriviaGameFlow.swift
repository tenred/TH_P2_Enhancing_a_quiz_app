//
//  TriviaGameFlow.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 20/10/16.
//

import Foundation
import GameKit

class TriviaGameFlow {
    
    private let questionsPerRound: Int
    private let triviaQuestion = QuestionData()
    
    private var questionsAsked = 0
    private var correctQuestions = 0
    private var indexOfSelectedQuestion = 0
    private var questionHistory: [Int] = []

    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        
    }
    
    func getTriviaQuestion() -> String{
        
        var questionAskedBefore: Bool

        repeat {
            
            questionAskedBefore = false
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestion.getTotalQuestionCount())
            
            if questionHistory != [] {
               for qn in questionHistory{
                    if qn == indexOfSelectedQuestion {
                        questionAskedBefore = true
                    }
                }
            }
            
        } while questionAskedBefore == true
        
        questionHistory.insert(indexOfSelectedQuestion, atIndex: questionHistory.endIndex)
        return triviaQuestion.question(atIndex: indexOfSelectedQuestion)
    }
    
    func getScore() -> (CorrectQuestions: Int, TotalQuestions: Int){
    
        return (correctQuestions, questionsPerRound)
    }
    
    func isAnswerCorrect(submittedAnswer: String) -> Bool {
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = triviaQuestion.answer(atIndex: indexOfSelectedQuestion)
        
        if submittedAnswer == correctAnswer {
            correctQuestions += 1
            return true
            
        } else {
            return false
        }
    }
    
    func isGameInPlay() -> Bool {
        
        if questionsAsked == questionsPerRound {
            // Game is over
            return false
        } else {
            // Continue game
            return true
        }
    }
    
    func questionOptions(OptionNo: Int) -> String {
        
        let arrAnswerOptions = triviaQuestion.answerOptions(atIndex: indexOfSelectedQuestion)
        return arrAnswerOptions[OptionNo]
    }
    
    func playAgain() {
        
        questionsAsked = 0
        correctQuestions = 0
        questionHistory.removeAll()
    }
}

