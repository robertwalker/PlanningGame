//
//  Game.swift
//  
//
//  Created by Robert Walker on 11/23/20.
//

import Foundation

enum GameError: Error {
    case lastRoundHasNotEnded
    case lastRoundNotFound
    case playerAlreadyAdded
    case playerNotFound
    case roundMustHaveUniqueStoryName
    case roundMustBeScoredBeforeStartingNextRound
}

enum PointScale {
    case powersOfTwo
    case linear
    case fibonacci
}

struct Game {
    var gameMaster: Player
    let pointScale: PointScale
    var players = [Player]()
    var rounds = [Round]()
    var playerCards = [PlayerCard]() {
        didSet {
            endRoundIfLastPlay()
        }
    }
    var lastRound: Round? { rounds.last }

    init(gameMaster: Player, pointScale: PointScale) {
        self.gameMaster = gameMaster
        self.pointScale = pointScale
    }

    func findPlayerCard(_ card: PlayerCard) -> PlayerCard? {
        return playerCards.first { $0 == card }
    }
    
    func findRound(_ round: Round) -> Round? {
        return rounds.first { $0 == round }
    }

    mutating func add(player: Player) throws {
        let activePlayer = self.players.first { $0 == player }
        guard activePlayer == nil else {
            throw GameError.playerAlreadyAdded
        }
        players.append(player)
    }
    
    mutating func startRound(round: Round) throws {
        let possibleRound = findRound(round)
        guard possibleRound == nil else {
            throw GameError.roundMustHaveUniqueStoryName
        }
        guard lastRound?.pointValue != .question else {
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
    
    mutating func playACard(player localPlayer: Player, card: PlayingCard) throws {
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

        appendOrReplacePlayerCard(with: PlayerCard(player: foundPlayer, playingCard: playedCard))
    }
    
    mutating func scoreRound(card: PlayingCard) throws {
        guard var lastRound = lastRound else {
            throw GameError.lastRoundNotFound
        }
        guard lastRound.hasEnded else {
            throw GameError.lastRoundHasNotEnded
        }
        
        lastRound.pointValue = card.faceValue
        rounds[rounds.count - 1] = lastRound
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
    
    private mutating func appendOrReplacePlayerCard(with playerCard: PlayerCard) {
        let foundCard = playerCards.first { $0.player == playerCard.player }
        if let _ = foundCard {
            playerCards = playerCards.map({ $0.player == playerCard.player ? playerCard : $0 })
        } else {
            playerCards.append(playerCard)
        }
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
