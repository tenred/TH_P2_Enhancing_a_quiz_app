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
    
    init() {
    let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
    let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        
    }
    
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}
