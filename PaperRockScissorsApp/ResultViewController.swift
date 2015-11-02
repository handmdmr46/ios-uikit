//
//  ResultViewController.swift
//  PaperRockScissorsApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var play: RPSMatch!
    var message: NSString!
    var picture: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.resultImageView.image = imageForPlay(play)
        self.messageLabel.text = messageForPlay(play)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animateWithDuration(1.5) {
            self.resultImageView.alpha = 1
        }
    }
    
    @IBAction func playAgain(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func messageForPlay(match: RPSMatch) -> String {
        // tie
        if (match.p1 == match.p2) {
            return "It's a Tie!"
        }
        
        // build message "RockCrushesScissors. You Win!" etc....
        return match.winner.description + " " + winnerModeString(match.winner) + " " + match.loser.description + " " + resultString(match)
    }
    
    func resultString(match: RPSMatch) -> String {
        return match.p1.defeat(match.p2) ? "You Win!" : "You Lose!"
    }
    
    func imageForPlay(match: RPSMatch) -> UIImage {
        var name = ""
        
        switch (match.winner) {
        case .Scissors:
            name = "ScissorsCutPaper"
        case .Rock:
            name = "RockCrushesScissors"
        case .Paper:
            name = "PaperCoversRock"
        }
        
        if (match.p1 == match.p2) {
            name = "itsATie"
        }
        
        return UIImage(named: name)!
    }
    
    func winnerModeString(mode: RPS) -> String {
        switch (mode) {
        case .Scissors:
            return "cuts"
        case .Rock:
            return "crushes"
        case .Paper:
            return "covers"
        }
    }
}
