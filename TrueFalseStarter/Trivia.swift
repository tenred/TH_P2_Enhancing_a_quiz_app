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
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Batman", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]

    func getQuestion(atIndex Index: Int) -> String {
        //Function returns individual Question String at an Index in Trivia Array

        let triviaQuestion = rawTriviaData[Index]
        return triviaQuestion["Question"]!
    }
    
    func getAnswer(atIndex Index: Int) -> String {
        //Function returns individual Answer String at an Index in Trivia Array
        
        let triviaAnswer = rawTriviaData[Index]
        return triviaAnswer["Answer"]!
    }
    
    func getTotalQuestionCount() -> Int {
        
        return rawTriviaData.count
    }
    
} // End of Struct QuestionData




