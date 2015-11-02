//
//  PlayViewController.swift
//  PaperRockScissorsApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    var playHistory = [RPSMatch]()
    
    @IBAction func makeYourMove(sender: UIButton) {
        
        // The RPS enum holds a player's move
        switch (sender) {
        case self.rockButton:
            throwDown(RPS.Rock)
            
        case self.paperButton:
            throwDown(RPS.Paper)
            
        case self.scissorsButton:
            throwDown(RPS.Scissors)
            
        default:
            assert(false, "An unknown button is invoking makeYourMove()")
        }
    }
    
    /*
    ** (1)randomly generates an opponent move, (2)stores result of the play, (3)add play to history, (4)present ResultViewController and pass play results
    */
    func throwDown(playerMove: RPS) {
        // (1) RPS randomly generates an opponent move
        let computerMove = RPS()
        
        // (2) RPSMatch stores result of the play
        let match = RPSMatch(p1: playerMove, p2: computerMove)
        
        // (3) add play to history array
        self.playHistory.append(match)
        
        // (4)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        vc.play = match
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func playLog(sender: UIBarButtonItem) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PlayLogViewController") as! PlayLogViewController
        vc.playHistory = self.playHistory
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
}

