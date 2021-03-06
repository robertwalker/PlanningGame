//
//  PlayerCard.swift
//  
//
//  Created by Robert Walker on 12/21/20.
//

import Foundation

public struct PlayerCard: Equatable {
    public let player: Player
    public let playingCard: PlayingCard
    
    public init(player: Player, playingCard: PlayingCard) {
        self.player = player
        self.playingCard = playingCard
    }
}
