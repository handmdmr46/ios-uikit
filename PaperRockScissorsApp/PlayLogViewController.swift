//
//  PlayLogViewController.swift
//  PaperRockScissorsApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

class PlayLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var playHistory: [RPSMatch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func playAgain(sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PlayViewController") as! PlayViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayHistoryCell") as UITableViewCell!
        
        let play = self.playHistory[indexPath.row]
        
        cell.imageView?.image = imageForPlay(play)
        cell.textLabel!.text = victoryStatusDescription(play)
        cell.detailTextLabel!.text = "\(play.p1) vs. \(play.p2) Date/Time: \(play.date.description)"
        
        return cell
    }
    
    func victoryStatusDescription(match: RPSMatch) -> String {
        
        if (match.p1 == match.p2) {
            return "Tie."
        } else if (match.p1.defeat(match.p2)) {
            return "Win!"
        } else {
            return "Loss."
        }
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
    
}

