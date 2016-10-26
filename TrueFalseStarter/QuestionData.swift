//
//  Trivia.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 19/10/16.
//

import Foundation

struct QuestionData {

    // Question object type to store and generate trivia questions.
    
    private let rawTriviaData: [[String : String]] = [
        ["Question": "How old is Ned Flanders?", "Answer": "60", "Options" : "55|60|38|19"],
        ["Question": "What age range is Homer known to be in ?", "Answer": "36-40","Options" : "32-35|36-40|41-44|45-48"],
        ["Question": "Who has tried many times to kill Bart?", "Answer": "Sideshow Bob","Options" : "Sideshow Mel|Krusty|Sideshow Bob|Ned Flanders"],
        ["Question": "What does Lineal Hutz work as?", "Answer": "Lawyer", "Options" : "Lawyer|Lollipop Man|Ice cream Man|Bartender"],
        ["Question": "In Shelbyville what is the name of the bar?", "Answer": "Joe's Tavern", "Options" : "Moe's Tavern|Joe's Bars|Moe's Bar|Joe's Tavern"],
        ["Question": "Where does Bart make a prank call to?", "Answer": "Australia", "Options" : "Canada|Australia|Japan|France"],
        ["Question": "What is Maggie's first word?", "Answer": "Daddy", "Options" : "Mummy|Bart|Grampa|Daddy"],
        ["Question": "Who wears a purple beenie?", "Answer": "Jimbo", "Options" : "Nelson|Ralph|Jimbo|Moe"],
        ["Question": "What is the horrible toy at Christmas called?", "Answer": "Funzo", "Options" : "Furbie|Funzo|Herbie|Krusty Doll"],
        ["Question": "Who is the news reporter for channel six?", "Answer": "Kent Brockman", "Options" : "Kent Brockman|Bumblebee Man|Krusty|Homer"],
        ["Question": "What is Arnie Pie's job?", "Answer": "Traffic Reporter", "Options" : "Clown|Bully|Principle|Traffic Reporter"],
        ["Question": "What is the ranch that Marge goes to called?", "Answer": "Rancho Relaxo", "Options" : "Ranch Love|Ranch Rest|Rancho Relaxo|R. Relaxo"],
        ["Question": "What was Ned Flanders wife's name?", "Answer": "Maude", "Options" : "Ruth|Edna|Maude|Marge"],
        ["Question": "Where does Milhouse's dad work?", "Answer": "The Cracker Factory", "Options" : "The Nuclear Power Plant|Springfield Elementry|Moe's Tavern|The Cracker Factory"],
        ["Question": "On the Bouvier Family Quilt, what does Marge's patch say?", "Answer": "Keep On Truckin", "Options" : "Love Will Find A Way|Keep On Truckin|Life Is Like A Box Of Chocolates|Marge Loves Homer 4-Ever"],
        ["Question": "What is Bart's treasured childhood toy named?", "Answer": "Mr. Honeybunny", "Options" : "Winney the Poop|Mr. Honeybunny|Murtle the Turtle|Radio Active Man"],
        ["Question": "How much money does Bart sell his soul to Milhouse for?", "Answer": "$5", "Options" : "$4|$5|$10|$8"],
        ["Question": "Who tells Ralph Wiggum to burn things?", "Answer": "A Leprechaun", "Options" : "A Clown|The Devil|A Leprechaun|Apu"],
        ["Question": "Who did Marge have a crush on when she was Lisa's age?", "Answer": "Ringo Star", "Options" : "Ringo Star|Bobbie Sherman|Ted Bessel|Homer Simpson"],
        ["Question": "Who ran over Snowball 1?", "Answer": "Clovis Quimby", "Options" : "Doctor Hibbet|Cletus|Homer|Clovis Quimby"]
  
        ]

    func question(atIndex Index: Int) -> String {
        //Description: Returns an individual Question at an Index of the Trivia Array
        
        let triviaQuestion = rawTriviaData[Index]
        return triviaQuestion["Question"]!
    }
    
    func answer(atIndex Index: Int) -> (answerString: String, answerIndex: Int) {
        //Description: Function returns individual Answer String at an Index in Trivia Array

        let triviaAnswer = rawTriviaData[Index]
        var triviaAnswerAtIndex: Int = -1
        var count: Int = 0
        
        for answer in answerOptions(atIndex: Index) {

            if answer == triviaAnswer["Answer"]{
                triviaAnswerAtIndex = count
            }
            count += 1
        }
        
        return (triviaAnswer["Answer"]!,triviaAnswerAtIndex)
    
        
    }
    
    func getTotalQuestionCount() -> Int {
        //Description: Returns the total number of questions within the rawTriviaData array
        return rawTriviaData.count
    }
    
    func answerOptions(atIndex Index: Int) -> Array<String> {
        //Description: Returns an array of answer options based on an individual question.
        //The options are delimted by "|" within rawTriviaData collection.
        
        let answerOptions = rawTriviaData[Index]
        let arrAnswerOptions = answerOptions["Options"]?.componentsSeparatedByString("|")
        
        return arrAnswerOptions!
    }
    
    
} // End of Struct QuestionData




