import XCTest
@testable import App

final class GameSessionTests: XCTestCase {
    let blankName = " \t\r\n"
    
    // MARK: Describe Creating a Game Session
    
    func testShouldCreateGameSessionUsingLinearPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let session = GameSession(gameMaster: gameMaster, pointScale: .linear)
        
        // Then
        XCTAssertEqual(session.gameMaster.name, "Game Master")
        XCTAssertEqual(session.pointScale, .linear)
        XCTAssertEqual(session.players.count, 0)
        XCTAssertEqual(session.cardsInPlay.count, 0)
    }

    func testShouldCreateGameSessionUsingPowersOfTwoPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let session = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        
        // Then
        XCTAssertEqual(session.gameMaster.name, "Game Master")
        XCTAssertEqual(session.pointScale, .powersOfTwo)
        XCTAssertEqual(session.players.count, 0)
        XCTAssertEqual(session.cardsInPlay.count, 0)
    }

    func testShouldCreateGameSessionUsingFibonacciPointScale() {
        // Given
        let gameMaster = Player(name: "Game Master")

        // When
        let session = GameSession(gameMaster: gameMaster, pointScale: .fibonacci)
        
        // Then
        XCTAssertEqual(session.gameMaster.name, "Game Master")
        XCTAssertEqual(session.pointScale, .fibonacci)
        XCTAssertEqual(session.players.count, 0)
        XCTAssertEqual(session.cardsInPlay.count, 0)
    }
    
    // MARK: - Describe Appending a Player
    
    func testShouldAppendAPlayerToPowersOfTwoGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var session = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        let playerOne = Player(name: "Player One")

        // When
        try! session.append(player: playerOne)
        
        // Then
        XCTAssertEqual(session.players.count, 1)
    }

    func testShouldAppendAPlayerToLinearGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var session = GameSession(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "Player One")

        // When
        try! session.append(player: playerOne)
        
        // Then
        XCTAssertEqual(session.players.count, 1)
    }

    func testShouldAppendAPlayerToFibonacciGame() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var session = GameSession(gameMaster: gameMaster, pointScale: .fibonacci)
        let playerOne = Player(name: "Player One")

        // When
        try! session.append(player: playerOne)
        
        // Then
        XCTAssertEqual(session.players.count, 1)
    }
    
    func testShouldNotAppendAPlayerWithBlankName() {
        // Given
        let gameMaster = Player(name: "Game Master")
        var session = GameSession(gameMaster: gameMaster, pointScale: .powersOfTwo)
        let playerOne = Player(name: blankName)

        // When
        try? session.append(player: playerOne)
        
        // Then
        XCTAssertEqual(session.players.count, 0)
    }
    
    // MARK: - Describe Starting a Game Round
    
    func testShouldStartALinearGameRound() {
        // Given
        var session = makeTwoPlayerGameSession(pointScale: .linear)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! session.startRound(round: round)
        
        // Then
        XCTAssertEqual(session.rounds[0].storyName, "Test Story")
        XCTAssertEqual(session.rounds[0].pointValue, .question)
        XCTAssertEqual(session.players[0].hand, playerHandLinear)
    }

    func testShouldStartAPowersOfTwoGameRound() {
        // Given
        var session = makeTwoPlayerGameSession(pointScale: .powersOfTwo)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! session.startRound(round: round)
        
        // Then
        XCTAssertEqual(session.rounds[0].storyName, "Test Story")
        XCTAssertEqual(session.rounds[0].pointValue, .question)
        XCTAssertEqual(session.players[0].hand, playerHandPowersOfTwo)
    }
    
    func testShouldStartAFibonaciiGameRound() {
        // Given
        var session = makeTwoPlayerGameSession(pointScale: .fibonacci)
        let round = GameRound(storyName: "Test Story")
        
        // When
        try! session.startRound(round: round)
        
        // Then
        XCTAssertEqual(session.rounds[0].storyName, "Test Story")
        XCTAssertEqual(session.rounds[0].pointValue, .question)
        XCTAssertEqual(session.players[0].hand, playerHandFibonacci)
    }
    
    func testShouldNotStartAGameRoundWithABlankStoryName() {
        // Given
        var session = makeTwoPlayerGameSession(pointScale: .linear)
        let round = GameRound(storyName: blankName)

        // When
        try? session.startRound(round: round)
        
        // Then
        XCTAssertEqual(session.rounds.count, 0, "Game round should not have been started, but was")
    }
}
