//
//  TriviaGameFlow.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 20/10/16.
//
// Description: This class controlls the flow of the trivia game 

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
        // Description: Returns a unique trivia question from QuestionData().
    
        var questionAskedBefore: Bool

        repeat {
            questionAskedBefore = false
            
            //Randomly generate index No. based on total values in triviaQuestion dataset
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestion.getTotalQuestionCount())
            
            //questionHistory as an array to append all questions asked historically for validation.
            //Check indexOfSelectedQuestion against the historical questionHistory to ensure question has not been asked before.
            //If question has been asked, repeat loop.
            if questionHistory != [] {
               for qn in questionHistory{
                    if qn == indexOfSelectedQuestion {
                        questionAskedBefore = true
                    }
                }
            }
            
        } while questionAskedBefore == true
        
        
        //append indexOfSelectedQuestion to array of historical questions.
        questionHistory.insert(indexOfSelectedQuestion, atIndex: questionHistory.endIndex)
        return triviaQuestion.question(atIndex: indexOfSelectedQuestion)
    }
    
    func getScore() -> (CorrectQuestions: Int, TotalQuestions: Int){
        //Description: returns the overall game score.
        
        return (correctQuestions, questionsPerRound)
    }
    
    func isAnswerCorrect(submittedAnswer: String?) -> Bool {
        //Desctipion: Returns true or false if the submitted question is correct.
        
        questionsAsked += 1
        let correctAnswer = triviaQuestion.answer(atIndex: indexOfSelectedQuestion)
        
        if submittedAnswer == correctAnswer.answerString{
            //Answer is Correct
            correctQuestions += 1
            return true
            
        } else {
            //Answer is not Correct
            return false
        }
    }
    
    func correctAnswerAtIndex() -> Int {
        //Description: Returns a numberical index value of the correct answer.
        
        return triviaQuestion.answer(atIndex: indexOfSelectedQuestion).answerIndex
    }
    
    
    func isGameInPlay() -> Bool {
        //Description: Returns True or False to determine if the game is currently being played.
        
        if questionsAsked == questionsPerRound {
            // Game is over
            return false
        } else {
            // Continue game
            return true
        }
    }
    
    func questionOptions(OptionNo: Int) -> String {
        //Description: Returns an indiviual answer Option based on an Index Num.
        //Each question currently has 4 options
        
        let arrAnswerOptions = triviaQuestion.answerOptions(atIndex: indexOfSelectedQuestion)
        return arrAnswerOptions[OptionNo]

    }
    
    func playAgain() {
        //Description: Will resert all class instances if the users chooses to play another game.
        
        questionsAsked = 0
        correctQuestions = 0
        questionHistory.removeAll()
    }
    
  } //End of Class

