//
//  GameInteractor.swift
//  
//
//  Created by Robert Walker on 12/10/20.
//

import Foundation

class GameInteractor {
    var gameSessions: [GameSession] = []
    
    func createGameSession(request: StartGameRequester) {
        let gameSession = GameSession(gameMaster: request.gameMaster, pointScale: request.pointScale)
        gameSessions.append(gameSession)
    }
    
    func registerPlayer(player: Player) throws {
        try gameSessions[0].append(player: player)
    }
    
    func startGameRound(storyName: String) throws {
        let round = GameRound(storyName: storyName)
        try gameSessions[0].startRound(round: round)
    }
}
