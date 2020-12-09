import XCTest
@testable import App

final class GameSessionTests: XCTestCase {
    let blankName = " \t\r\n"
    
    // MARK: Describe Creating a Game Session
    
    func testShouldCreateGameSessionUsingLinearPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let gameSession = GameSession(gameMaster: gameMaster, pointScale: .linear)
        
        // Then
        XCTAssertEqual(gameSession.gameMaster.name, "Game Master")
        XCTAssertEqual(gameSession.pointScale, .linear)
        XCTAssertEqual(gameSession.players.count, 0)
        XCTAssertEqual(gameSession.gameBoard.cardsInPlay.count, 0)
    }

    func testShouldCreateGameSessionUsingPowersOfTwoPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let gameSession = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        
        // Then
        XCTAssertEqual(gameSession.gameMaster.name, "Game Master")
        XCTAssertEqual(gameSession.pointScale, .powersOfTwo)
        XCTAssertEqual(gameSession.players.count, 0)
        XCTAssertEqual(gameSession.gameBoard.cardsInPlay.count, 0)
    }

    func testShouldCreateGameSessionUsingFibonacciPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let gameSession = GameSession(gameMaster: gameMaster, pointScale: .fibonacci)
        
        // Then
        XCTAssertEqual(gameSession.gameMaster.name, "Game Master")
        XCTAssertEqual(gameSession.pointScale, .fibonacci)
        XCTAssertEqual(gameSession.players.count, 0)
        XCTAssertEqual(gameSession.gameBoard.cardsInPlay.count, 0)
    }
    
    // MARK: - Describe Appending a Player
    
    func testShouldAppendAPlayerToPowersOfTwoGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var gameSession = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        let playerOne = Player(name: "Player One")

        // When
        try! gameSession.append(player: playerOne)
        
        // Then
        XCTAssertEqual(gameSession.players.count, 1)
    }

    func testShouldAppendAPlayerToLinearGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var gameSession = GameSession(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "Player One")

        // When
        try! gameSession.append(player: playerOne)
        
        // Then
        XCTAssertEqual(gameSession.players.count, 1)
    }

    func testShouldAppendAPlayerToFibonacciGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var gameSession = GameSession(gameMaster: gameMaster, pointScale: .fibonacci)
        let playerOne = Player(name: "Player One")

        // When
        try! gameSession.append(player: playerOne)
        
        // Then
        XCTAssertEqual(gameSession.players.count, 1)
    }
    
    func testShouldNotAppendAPlayerWithBlankName() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var gameSession = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        let playerOne = Player(name: blankName)

        // When
        try? gameSession.append(player: playerOne)
        
        // Then
        XCTAssertEqual(gameSession.players.count, 0)
    }
    
    // MARK: - Describe Starting a Game Round
    
    func testShouldStartALinearGameRound() {
        // Given
        var gameSession = makeTwoPlayerGameSession(pointScale: .linear)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! gameSession.startRound(round: round)
        
        // Then
        XCTAssertEqual(gameSession.rounds[0].storyName, "Test Story")
        XCTAssertEqual(gameSession.rounds[0].pointValue, .question)
        XCTAssertEqual(gameSession.players[0].hand, playerHandLinear)
    }

    func testShouldStartAPowersOfTwoGameRound() {
        // Given
        var gameSession = makeTwoPlayerGameSession(pointScale: .powersOfTwo)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! gameSession.startRound(round: round)
        
        // Then
        XCTAssertEqual(gameSession.rounds[0].storyName, "Test Story")
        XCTAssertEqual(gameSession.rounds[0].pointValue, .question)
        XCTAssertEqual(gameSession.players[0].hand, playerHandPowersOfTwo)
    }
    
    func testShouldStartAFibonaciiGameRound() {
        // Given
        var gameSession = makeTwoPlayerGameSession(pointScale: .fibonacci)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! gameSession.startRound(round: round)
        
        // Then
        XCTAssertEqual(gameSession.rounds[0].storyName, "Test Story")
        XCTAssertEqual(gameSession.rounds[0].pointValue, .question)
        XCTAssertEqual(gameSession.players[0].hand, playerHandFibonacci)
    }
    
    func testShouldNotStartAGameRoundWithABlankStoryName() {
        // Given
        var gameSession = makeTwoPlayerGameSession(pointScale: .linear)
        let round = GameRound(storyName: blankName)

        // When
        try? gameSession.startRound(round: round)
        
        // Then
        XCTAssertEqual(gameSession.rounds.count, 0, "Game round should not have been started, but was")
    }
}
