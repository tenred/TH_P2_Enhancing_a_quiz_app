//
//  GameAudio.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 20/10/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit
import AudioToolbox

struct AudioControl {
    
    var gameSound: SystemSoundID = 0
    
    let startGameAudioFile = NSBundle.mainBundle().pathForResource("StartGame", ofType: "wav")
    let endGameAudioFile = NSBundle.mainBundle().pathForResource("EndGame", ofType: "wav")
    let correctAnswAudioFile = NSBundle.mainBundle().pathForResource("CorrectAnswer", ofType: "wav")
    let wrongAnswAudioFile = NSBundle.mainBundle().pathForResource("WrongAnswer", ofType: "wav")

    init() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("StartGame", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
  /*  func loadGameStartSound(pathToSoundFile: NSBundle) {
        
        //let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        
    }
*/
  


    
    
    func playStartSound() {

        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    func playCorrectAnswer(){
        
    }
    
    func playWrongAnswer(){
        
    }
    
    func finishGame(){
        
    }
    
}
