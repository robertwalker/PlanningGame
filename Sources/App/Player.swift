//
//  Player.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

struct Player {
    let name: String
    var hand: [PlayingCard] = []
    
    init(name: String) {
        self.name = name
    }
}

extension Player: Equatable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
