//
//  Game.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

public enum GameError: Error {
    case lastRoundHasNotEnded
    case lastRoundNotFound
    case playerAlreadyAdded
    case playerNotFound
    case roundMustHaveUniqueStoryName
    case roundMustBeScoredBeforeStartingNextRound
    case scoredRoundsCannotBeReplayed
}

public enum PointScale: String {
    case powersOfTwo = "powersOfTwo"
    case linear = "linear"
    case fibonacci = "fibonacci"
}

public struct Game {
    public var gameMaster: Player
    public let pointScale: PointScale
    public var players: [Player] = []
    public var rounds: [Round] = []
    public var playerCards: [PlayerCard] = [] {
        didSet {
            endRoundIfLastPlay()
        }
    }
    public var lastRound: Round? { rounds.last }
    
    public init(gameMaster: Player, pointScale: PointScale) {
        self.gameMaster = gameMaster
        self.pointScale = pointScale
    }
    
    public func findPlayerCard(_ card: PlayerCard) -> PlayerCard? {
        return playerCards.first { $0 == card }
    }
    
    public func findRound(_ round: Round) -> Round? {
        return rounds.first { $0 == round }
    }
    
    public mutating func addPlayer(_ player: Player) throws {
        let activePlayer = self.players.first { $0 == player }
        guard activePlayer == nil else {
            throw GameError.playerAlreadyAdded
        }
        players.append(player)
    }
    
    public mutating func removePlayer(_ player: Player) {
        players = players.filter { $0 != player }
    }
    
    public mutating func startRound(round: Round) throws {
        let possibleRound = findRound(round)
        guard possibleRound == nil else {
            throw GameError.roundMustHaveUniqueStoryName
        }
        guard lastRound?.scoreCard != PlayingCard(faceValue: .question) else {
            throw GameError.roundMustBeScoredBeforeStartingNextRound
        }
        
        gameMaster.hand = dealPointCards()
        players = players.map({ (player) -> Player in
            var playerCopy = player
            playerCopy.hand = dealPlayerCards()
            return playerCopy
        })
        rounds.append(round)
    }
    
    public mutating func playACard(player localPlayer: Player, card: PlayingCard) throws {
        var playedCard = card
        let possiblePlayer = self.players.first { $0 == localPlayer }
        guard let foundPlayer = possiblePlayer else {
            throw GameError.playerNotFound
        }
        
        players = players.map({ (player) -> Player in
            guard player == foundPlayer else {
                return player
            }
            
            var playerCopy = player
            playedCard.isFaceDown = true
            playerCopy.hand = player.hand.filter({ $0 != playedCard })
            return playerCopy
        })
        
        let playerCard = PlayerCard(player: foundPlayer, playingCard: playedCard)
        guard let replacedCard = appendOrReplacePlayerCard(with: playerCard) else {
            return
        }
        
        if var playerCopy = players.first(where: { $0 == foundPlayer }) {
            playerCopy.hand.append(replacedCard)
            players = players.map { $0.name == playerCopy.name ? playerCopy : $0 }
        }
    }
    
    public mutating func replayRound() throws {
        guard var lastRoundCopy = lastRound else {
            throw GameError.lastRoundNotFound
        }
        guard lastRoundCopy.scoreCard.faceValue == .question else {
            throw GameError.scoredRoundsCannotBeReplayed
        }
        
        lastRoundCopy.hasEnded = false
        rounds[rounds.count - 1] = lastRoundCopy

        playerCards = []
        
        gameMaster.hand = dealPointCards()
        players = players.map({ (player) -> Player in
            var playerCopy = player
            playerCopy.hand = dealPlayerCards()
            return playerCopy
        })
    }
    
    public mutating func scoreRound(card: PlayingCard) throws {
        guard var lastRoundCopy = lastRound else {
            throw GameError.lastRoundNotFound
        }
        guard lastRoundCopy.hasEnded else {
            throw GameError.lastRoundHasNotEnded
        }
        
        lastRoundCopy.scoreCard = card
        rounds[rounds.count - 1] = lastRoundCopy
        
        playerCards = []
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
        hand.append(PlayingCard(faceValue: .skip))
        return hand
    }
    
    private mutating func appendOrReplacePlayerCard(with playerCard: PlayerCard) -> PlayingCard? {
        let possibleCard = playerCards.first { $0.player == playerCard.player }
        guard let card = possibleCard else {
            playerCards.append(playerCard)
            return nil
        }
        
        playerCards = playerCards.map({ $0.player == playerCard.player ? playerCard : $0 })
        return card.playingCard
    }
    
    private mutating func endRoundIfLastPlay() {
        guard playerCards.count == players.count else {
            return
        }
        rounds = rounds.map({ (round) -> Round in
            var localRound = round
            localRound.hasEnded = true
            return localRound
        })
    }
}
