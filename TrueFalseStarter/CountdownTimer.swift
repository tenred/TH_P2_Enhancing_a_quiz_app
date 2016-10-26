//
//  CountdownTimer.swift
//  TrueFalseStarter
//
//  Created by Sherief Wissa on 25/10/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
// Description: This class controls the timer with Lightning mode is invoked.
//


import Foundation

class CountdownTimer {
    
    let totalTimerInSeconds: Int
    private var timerCount: Int
    private var timer: NSTimer?
    var lightningModeEnabled: Bool = false
    
    init(timerInSeconds: Int) {
        self.totalTimerInSeconds = timerInSeconds
        self.timerCount = totalTimerInSeconds
    }
    
    
    func countingDown() -> Int {
    //Description: Returns a countdown value decreased by 1 when called.
        
        let count: Int = timerCount
        timerCount -= 1
        return count
 }
    
    func isActive() -> Bool {
    //Description: Returns True of False to determin if the counter is still in progress.

        if timerCount > 0{
            return true
        } else {
            resetTime()
            return false
        }
    }
    
    func resetTime() {
        //Description: Resets the timer count upon the completion of an individual question
        
        timerCount = totalTimerInSeconds
        
    }
    
    func resetLightningMode() {
        //Description: Resets the timer count upon completion of the entire Game.
        
        resetTime()
        lightningModeEnabled = false
    }
    
    
}
