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
        XCTAssertEqual(game.playerCards.count, 0)
    }

    func testShouldCreateGameUsingPowersOfTwoPointScale() throws {
        // When
        let game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .powersOfTwo))

        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .powersOfTwo)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.playerCards.count, 0)
    }

    func testShouldCreateGameUsingFibonacciPointScale() throws {
        // When
        let game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .fibonacci))

        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .fibonacci)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.playerCards.count, 0)
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

    func testShouldNotAddAPlayerMoreThanOnce() throws {
        // Given
        var game = try XCTUnwrap(Game(gameMaster: gameMaster, pointScale: .linear))
        let playerOne = try XCTUnwrap(Player(name: "Player One"))
        let playerTwo = try XCTUnwrap(Player(name: "Player Two"))

        // When/Then
        XCTAssertNoThrow(try game.add(player: playerOne))
        XCTAssertNoThrow(try game.add(player: playerTwo))
        XCTAssertThrowsError(try game.add(player: playerOne))
        XCTAssertEqual(game.players.count, 2)
    }
    
    // MARK: - Describe Starting a Round
    
    func testShouldStartALinearRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .linear)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))
        
        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.pointValue, .question)
        XCTAssertEqual(game.players[0].hand, playerHandLinear)
    }

    func testShouldStartAPowersOfTwoRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .powersOfTwo)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))

        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.pointValue, .question)
        XCTAssertEqual(game.players.first?.hand, playerHandPowersOfTwo)
    }
    
    func testShouldStartAFibonaciiRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .fibonacci)
        let round = try XCTUnwrap(Round(storyName: "Test Story"))

        // When
        game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.pointValue, .question)
        XCTAssertEqual(game.players.first?.hand, playerHandFibonacci)
    }

    // MARK: - Describe Finding a PlayerCard
    
    func testShouldFindAPlayerCardInPlayedCards() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playingCard = try XCTUnwrap(playerOne.hand.first)
        let expectedPlayerCard = PlayerCard(player: playerOne, playingCard: playingCard)
        game.playerCards = [expectedPlayerCard]
        
        // When
        let actualPlayerCard = game.findPlayerCard(playerCard: expectedPlayerCard)
        
        // Then
        XCTAssertEqual(actualPlayerCard, expectedPlayerCard)
    }
    
    // MARK: - Describe Playing a Card

    func testShouldRemoveThePlayedCardFromPlayersHand() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let chosenCardFromHand = try XCTUnwrap(game.players.first?.hand.first)
        let expectedPlayerHand = playerHandLinear.filter { $0 != chosenCardFromHand }

        // When
        try game.playACard(player: playerOne, card: chosenCardFromHand)

        // Then
        let actualPlayerHand = try XCTUnwrap(game.players.first?.hand)
        XCTAssertEqual(actualPlayerHand, expectedPlayerHand, "Expected played card to be removed from player's hand")
    }

    func testShouldAppendThePlayersChosenCardToPlayedCards() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let chosenCardFromHand = try XCTUnwrap(game.players.first?.hand.first)
        let expectedPlayedCards = [PlayerCard(player: playerOne, playingCard: chosenCardFromHand)]

        // When
        try game.playACard(player: playerOne, card: chosenCardFromHand)

        // Then
        XCTAssertEqual(game.playerCards, expectedPlayedCards, "Expected chosen card to be added to game's played cards")
    }

    func testShouldFlipThePlayedCardFaceDown() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let chosenCardFromHand = try XCTUnwrap(game.players.first?.hand.first)
        let expectedPlayerCard = PlayerCard(player: playerOne, playingCard: chosenCardFromHand)

        // When
        try game.playACard(player: playerOne, card: chosenCardFromHand)

        // Then
        let actualPlayerCard = try XCTUnwrap(game.findPlayerCard(playerCard: expectedPlayerCard))
        XCTAssertTrue(actualPlayerCard.playingCard.isFaceDown, "Expected played card to be face down")
    }

    func testShouldReplacePlayerCardInPlayedCards() throws {
        // Given
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playerTwo = try XCTUnwrap(game.players[1])
        let firstPlayingCard = try XCTUnwrap(playerOne.hand.first)
        let secondPlayingCard = try XCTUnwrap(playerOne.hand[1])
        let expectedPlayerCard = PlayerCard(player: playerOne, playingCard: secondPlayingCard)
        
        // When
        try game.playACard(player: playerOne, card: firstPlayingCard)
        try game.playACard(player: playerTwo, card: firstPlayingCard)
        try game.playACard(player: playerOne, card: secondPlayingCard)
        
        // Then
        let actualPlayerCard = try XCTUnwrap(game.findPlayerCard(playerCard: expectedPlayerCard))
        XCTAssertEqual(game.playerCards.count, 2)
        XCTAssertEqual(actualPlayerCard, expectedPlayerCard)
    }
    
    func testShouldNotPlayACardWherePlayerIsNotInGame() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerTwo = try XCTUnwrap(Player(name: "Player Two"))
        let playingCard = PlayingCard(faceValue: .one)
        
        // Then
        XCTAssertThrowsError(try game.playACard(player: playerTwo, card: playingCard))
    }
    
    // MARK: - Describe Ending a Round
    
    func testShouldEndCurrentRoundWhenAllPlayersHavePlayed() throws {
        // Given
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playerTwo = try XCTUnwrap(game.players[1])
        let playerOneCard = try XCTUnwrap(playerOne.hand.first)
        let playerTwoCard = try XCTUnwrap(playerTwo.hand.first)

        // When
        try game.playACard(player: playerOne, card: playerOneCard)
        try game.playACard(player: playerTwo, card: playerTwoCard)
        
        // Then
        let currentRound = try XCTUnwrap(game.lastRound)
        XCTAssertTrue(currentRound.hasEnded)
    }

    func testShouldNotEndCurrentRoundSomePlayersHaveNotPlayed() throws {
        // Given
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playerOneCard = try XCTUnwrap(playerOne.hand.first)

        // When
        try game.playACard(player: playerOne, card: playerOneCard)
        
        // Then
        let currentRound = try XCTUnwrap(game.lastRound)
        XCTAssertFalse(currentRound.hasEnded)
    }
}
