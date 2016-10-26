//
//  GameAudio.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 20/10/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
// Description: This struct controls the inApp audio based on the different events within the gameplay.
//


import Foundation
import GameKit
import AudioToolbox

struct AudioControl {
    
    private var gameSound: SystemSoundID = 0
    
    private let startGameAudioFile = "The Simpsons - Intro"
    private let correctAnswAudioFile = "Homer - Woohoo! (1)"
    private let wrongAnswAudioFile = "Homer - D'oh! (1)"
    private let arrEndGameAudio = ["Ralph - Wookie","Ralph - Red Crayon","Ralph - Glue","Homer - Mmmm, forbidden donut","Homer - Mmmm, chicken","Homer - Mmmm, beer","Homer - Kinichiwa","Homer - Everyone is stupid","Homer - Blubber","Grandpa - That's my ambulance","Grandpa - That racoon","Burns - Release the hounds","BeeGuy - No es bueno","Barney - Heart stopped","Apu - Please come again"]

    private mutating func loadAudio(audioFileName: String){
        //Description: initiates the Game Audio
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(audioFileName, ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        
    }
    
    mutating func playStartSound() {
        //Descrition: plays audio when the app is launched.
        loadAudio(startGameAudioFile)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    mutating func playCorrectAnswerSound(){
        //Descrition: plays audio when the a correct answer is selected.
        loadAudio(correctAnswAudioFile)
        AudioServicesPlaySystemSound(gameSound)
        
    }
    
    mutating func playWrongAnswerSound(){
        //Descrition: plays audio when an incorrect answer is selected.

        loadAudio(wrongAnswAudioFile)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    mutating func playFinishGameSound(){
        //Descrition: plays audio when the game is finished.
        //End Game Audio is randomly selected from array arrEndGameAudio
        
        let indexOfEndAudio = GKRandomSource.sharedRandom().nextIntWithUpperBound(arrEndGameAudio.count)
        
        loadAudio(arrEndGameAudio[indexOfEndAudio])
        AudioServicesPlaySystemSound(gameSound)
        
        
    }
    
}
