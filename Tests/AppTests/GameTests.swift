import XCTest
@testable import App

final class GameTests: XCTestCase {
    let gameMaster = Player(name: "Game Master")!

    // MARK: - Describe Creating a Game
    
    func testShouldCreateGameUsingLinearPointScale() throws {
        // When
        let game = Game(gameMaster: gameMaster, pointScale: .linear)
        
        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .linear)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.cardsInPlay.count, 0)
    }

    func testShouldCreateGameUsingPowersOfTwoPointScale() throws {
        // When
        let game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .powersOfTwo))

        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .powersOfTwo)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.cardsInPlay.count, 0)
    }

    func testShouldCreateGameUsingFibonacciPointScale() throws {
        // When
        let game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .fibonacci))

        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .fibonacci)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.cardsInPlay.count, 0)
    }
    
    // MARK: - Describe Adding a Player
    
    func testShouldAddAPlayer() throws {
        // Given
        var game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .linear))
        let playerOne = try XCTUnwrap(Player(name: "Player One"))

        // When
        try! game.add(player: playerOne)
        
        // Then
        XCTAssertEqual(game.players.count, 1)
    }
    
    // MARK: - Describe Starting a Round
    
    func testShouldStartALinearRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .linear)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))
        
        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.currentRound?.storyName, "Test Story")
        XCTAssertEqual(game.currentRound?.pointValue, .question)
        XCTAssertEqual(game.players[0].hand, playerHandLinear)
    }

    func testShouldStartAPowersOfTwoRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .powersOfTwo)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))

        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.currentRound?.storyName, "Test Story")
        XCTAssertEqual(game.currentRound?.pointValue, .question)
        XCTAssertEqual(game.players.first?.hand, playerHandPowersOfTwo)
    }
    
    func testShouldStartAFibonaciiRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .fibonacci)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))

        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.currentRound?.storyName, "Test Story")
        XCTAssertEqual(game.currentRound?.pointValue, .question)
        XCTAssertEqual(game.players.first?.hand, playerHandFibonacci)
    }
}
