//
//  Game.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

enum PointScale {
    case powersOfTwo
    case linear
    case fibonacci
}

struct Game {
    var gameMaster: Player
    let pointScale: PointScale
    var players: [Player] = []
    var rounds: [Round] = []
    var cardsInPlay: [PlayingCard] = []
    var currentRound: Round? { rounds.last }

    init(gameMaster: Player, pointScale: PointScale) {
        self.gameMaster = gameMaster
        self.pointScale = pointScale
    }

    mutating func add(player: Player) throws {
        players.append(player)
    }
    
    mutating func startRound(round: Round) {
        gameMaster.hand = dealPointCards()
        players = players.map({ (player) -> Player in
            var playerCopy = player
            playerCopy.hand = dealPlayerCards()
            return playerCopy
        })
        rounds.append(round)
    }

    // MARK: - Private Methods
    
    private func dealPointCards() -> [PlayingCard] {
        var hand = [
            PlayingCard(faceValue: .one),
            PlayingCard(faceValue: .two),
        ]
        switch pointScale {
        case .powersOfTwo:
            hand.append(PlayingCard(faceValue: .four))
            hand.append(PlayingCard(faceValue: .eight))
        case .linear:
            hand.append(PlayingCard(faceValue: .three))
        case .fibonacci:
            hand.append(PlayingCard(faceValue: .three))
            hand.append(PlayingCard(faceValue: .five))
            hand.append(PlayingCard(faceValue: .eight))
        }
        return hand
    }

    private func dealPlayerCards() -> [PlayingCard] {
        var hand = dealPointCards()
        hand.append(PlayingCard(faceValue: .question))
        return hand
    }
}
