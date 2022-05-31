//
//  Player.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

public struct Player {
    public let name: String
    public var hand: [PlayingCard] = []
    
    public init(name: String) {
        self.name = name
    }
}

extension Player: Equatable {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
    }
}
