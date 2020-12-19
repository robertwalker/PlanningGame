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
    
    init?(name: String) {
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return nil }
        self.name = name
    }
}
