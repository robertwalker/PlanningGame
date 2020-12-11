import XCTest
@testable import App

final class GameinteractorTests: XCTestCase {
    let blankName = " \t\r\n"

    var interactor = GameInteractor()
    let gameMaster = Player(name: "Game Master")
    let playerOne = Player(name: "Player One")

    // MARK: - Describe Creating a Game Sesion
    
    func testShouldCreateAGameUsingLinearPointScale() {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .linear)
        
        // When
        interactor.createGameSession(request: request)
        
        // Then
        XCTAssertEqual(interactor.gameSessions.count, 1)
    }

    func testShouldCreateAGameUsingPowersOfTwoPointScale() {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .powersOfTwo)
        
        // When
        interactor.createGameSession(request: request)
        
        // Then
        XCTAssertEqual(interactor.gameSessions.count, 1)
    }

    func testShouldCreateAGameUsingFibonacciPointScale() {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .fibonacci)
        
        // When
        interactor.createGameSession(request: request)
        
        // Then
        XCTAssertEqual(interactor.gameSessions.count, 1)
    }

    // MARK: - Describe Registering Players
    
    func testShouldRegisterAPlayer() throws {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .linear)
        interactor.createGameSession(request: request)

        // When
        try interactor.registerPlayer(player: playerOne)
        
        // Then
        XCTAssertEqual(interactor.gameSessions[0].players.count, 1)
    }
    
    func testShouldNotRegisterAPlayerWithAnInvalidName() {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .linear)
        interactor.createGameSession(request: request)
        let invalidPlayer = Player(name: blankName)

        // When
        try? interactor.registerPlayer(player: invalidPlayer)
        
        // Then
        XCTAssertEqual(interactor.gameSessions[0].players.count, 0)
    }
    
    // MARK: - Describe Start a Game Round
    
    func testShouldStartAGameRound() throws {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .linear)
        interactor.createGameSession(request: request)
        
        // When
        try interactor.startGameRound(storyName: "Test Story")
        
        // Then
        XCTAssertEqual(interactor.gameSessions[0].rounds.count, 1)
    }

    func testShouldNotStartAGameRoundWithAnInvalidGameMasterName() {
        // Given
        let invalidGameMaster = Player(name: blankName)
        let request = StartGameRequest(gameMaster: invalidGameMaster, pointScale: .linear)
        interactor.createGameSession(request: request)
        
        // When
        try? interactor.startGameRound(storyName: "Test Story")
        
        // Then
        XCTAssertEqual(interactor.gameSessions[0].rounds.count, 0)
    }

    func testShouldNotStartAGameRoundWithAnInvalidStoryName() {
        // Given
        let request = StartGameRequest(gameMaster: gameMaster, pointScale: .linear)
        interactor.createGameSession(request: request)
        
        // When
        try? interactor.startGameRound(storyName: blankName)
        
        // Then
        XCTAssertEqual(interactor.gameSessions[0].rounds.count, 0)
    }
}
