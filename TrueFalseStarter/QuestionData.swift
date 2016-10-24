//
//  Trivia.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 19/10/16.
//

import Foundation

struct QuestionData {

    // Question object type to store and generate trivia questions.
    //let questionIndex: Int
    
    private let rawTriviaData: [[String : String]] = [
        ["Question": "Only female koalas can whistle?", "Answer": "a", "Options" : "a|b|c|d"],
        ["Question": "Is Batman is Awesome?", "Answer": "e","Options" : "e|f|g|h"],
        ["Question": "Camels are cannibalistic", "Answer": "i","Options" : "i|j|k|l"],
        ["Question": "All ducks are birds", "Answer": "m", "Options" : "m|n|o|p"],
        ["Question": "Robin is Batman's Sidekick", "Answer": "q", "Options" : "q|r|s|t"],
        ["Question": "Joke is Batman's Enemy?", "Answer": "u", "Options" : "u|v|w|x"]
    ]

    func question(atIndex Index: Int) -> String {
        //Function returns individual Question String at an Index in Trivia Array
        
        let triviaQuestion = rawTriviaData[Index]
        return triviaQuestion["Question"]!
    }
    
    func answer(atIndex Index: Int) -> String {
        //Function returns individual Answer String at an Index in Trivia Array
        
        let triviaAnswer = rawTriviaData[Index]
        return triviaAnswer["Answer"]!
    }
    
    func getTotalQuestionCount() -> Int {
        
        return rawTriviaData.count
    }
    
    func answerOptions(atIndex Index: Int) -> Array<String> {
        
        let answerOptions = rawTriviaData[Index]
        let arrAnswerOptions = answerOptions["Options"]?.componentsSeparatedByString("|")
        
        return arrAnswerOptions!
    }
    
    
} // End of Struct QuestionData




