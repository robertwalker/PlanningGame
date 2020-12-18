//
//  GameSesison.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

enum GameRoundError: Error {
    case storyNameMustNotBeBlank
}

enum PlayerError: Error {
    case gameMasterNameMustNotBeBlank
    case playerNameMustNotBeBlank
}

enum PointScale {
    case powersOfTwo
    case linear
    case fibonacci
}

struct GameSession {
    var gameMaster: Player
    let pointScale: PointScale
    var gameBoard: GameBoard
    var players: [Player] = []
    var rounds: [GameRound] = []
    
    init(gameMaster: Player, pointScale: PointScale) {
        self.gameMaster = gameMaster
        self.pointScale = pointScale
        self.gameBoard = GameBoard()
    }

    mutating func append(player: Player) throws {
        guard hasValidPlayerName(player: player) else {
            throw PlayerError.playerNameMustNotBeBlank
        }
        
        players.append(player)
    }
    
    mutating func startRound(round: GameRound) throws {
        guard hasValidStoryName(round: round) else {
            throw GameRoundError.storyNameMustNotBeBlank
        }
        guard hasValidPlayerName(player: gameMaster) else {
            throw PlayerError.gameMasterNameMustNotBeBlank
        }
        
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

// MARK: - Utility Functions

fileprivate func hasValidPlayerName(player: Player) -> Bool {
    return player.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
}

fileprivate func hasValidStoryName(round: GameRound) -> Bool {
    return round.storyName.trimmingCharacters(in: .whitespacesAndNewlines) != ""
}
