//
//  RPS.swift
//  PaperRockScissorsApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//
import Foundation

enum RPS {
    case Rock, Paper, Scissors
    
    
    init() {
        // random opponent move
        switch arc4random() % 3 {
        case 0:
            self = .Rock
        case 1:
            self = .Paper
        default:
            self = .Scissors
        }
    }
    
    // define hierarchy, Paper defeats Rock - Rock defeats Scissors - etc...
    func defeat(opponent: RPS) -> Bool {
        
        switch (self, opponent) {
        case (.Paper, .Rock), (.Scissors, .Paper), (.Rock, .Scissors):
            return true;
        default:
            return false;
        }
    }
}

extension RPS: CustomStringConvertible {
    
    var description: String {
        get {
            switch (self) {
            case .Rock:
                return "Rock"
            case .Paper:
                return "Paper"
            case .Scissors:
                return "Scissors"
            }
        }
    }
}
