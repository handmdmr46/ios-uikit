//
//  RPSMatch.swift
//  PaperRockScissorsApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//
import Foundation

struct RPSMatch {
    
    let p1: RPS
    let p2: RPS
    let date: NSDate
    
    init(p1: RPS, p2: RPS) {
        self.p1 = p1
        self.p2 = p2
        self.date = NSDate()
    }
    
    var winner: RPS {
        get {
            return p1.defeat(p2) ? p1 : p2
        }
    }
    
    var loser: RPS {
        get {
            return p1.defeat(p2) ? p2 : p1
        }
    }
}
