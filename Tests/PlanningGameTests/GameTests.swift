import XCTest
@testable import PlanningGame

final class GameTests: XCTestCase {
    let gameMaster = Player(name: "Game Master")
    
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
        let game = Game(gameMaster: gameMaster, pointScale: .powersOfTwo)
        
        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .powersOfTwo)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.playerCards.count, 0)
    }
    
    func testShouldCreateGameUsingFibonacciPointScale() throws {
        // When
        let game = Game(gameMaster: gameMaster, pointScale: .fibonacci)
        
        // Then
        XCTAssertEqual(game.gameMaster.name, "Game Master")
        XCTAssertEqual(game.pointScale, .fibonacci)
        XCTAssertEqual(game.players.count, 0)
        XCTAssertEqual(game.playerCards.count, 0)
    }
    
    // MARK: - Describe Adding a Player
    
    func testShouldAddAPlayer() throws {
        // Given
        var game = Game(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "Player One")
        
        // When
        try game.addPlayer(playerOne)
        
        // Then
        XCTAssertEqual(game.players.count, 1)
    }
    
    func testShouldNotAddPlayerWithEmptyName() {
        // Given
        var game = Game(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "")
        
        // When/Then
        XCTAssertThrowsError(try game.addPlayer(playerOne))
    }
    
    func testShouldNotAddAPlayerMoreThanOnce() throws {
        // Given
        var game = Game(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "Player One")
        let playerTwo = Player(name: "Player Two")
        
        // When/Then
        XCTAssertNoThrow(try game.addPlayer(playerOne))
        XCTAssertNoThrow(try game.addPlayer(playerTwo))
        XCTAssertThrowsError(try game.addPlayer(playerOne))
        XCTAssertEqual(game.players.count, 2)
    }
    
    // MARK: - Describe Removing a Player
    
    func testShouldRemoveAPlayer() throws {
        // Setup
        var game = Game(gameMaster: gameMaster, pointScale: .linear)
        let playerOne = Player(name: "Player One")
        try game.addPlayer(playerOne)
        
        // Given
        let playerTwo = Player(name: "Player Two")
        
        // When
        game.removePlayer(playerTwo)
        
        // Then
        XCTAssertEqual(game.players.count, 1)
        XCTAssertTrue(game.players.contains(playerOne))
        XCTAssertFalse(game.players.contains(playerTwo))
    }
    
    // MARK: - Describe Starting a Round
    
    func testShouldStartALinearRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .linear)
        let round = Round(storyName: "Test Story")
        let scoreCard = PlayingCard(faceValue: .question)
        
        // When
        try game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.scoreCard, scoreCard)
        XCTAssertEqual(game.players[0].hand, playerHandLinear)
    }
    
    func testShouldStartAPowersOfTwoRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .powersOfTwo)
        let round = Round(storyName: "Test Story")
        let scoreCard = PlayingCard(faceValue: .question)
        
        // When
        try game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.scoreCard, scoreCard)
        XCTAssertEqual(game.players.first?.hand, playerHandPowersOfTwo)
    }
    
    func testShouldStartAFibonaciiRound() throws {
        // Given
        var game = makeTwoPlayerGame(pointScale: .fibonacci)
        let round = Round(storyName: "Test Story")
        let scoreCard = PlayingCard(faceValue: .question)
        
        // When
        try game.startRound(round: round)
        
        // Then
        XCTAssertEqual(game.lastRound?.storyName, "Test Story")
        XCTAssertEqual(game.lastRound?.scoreCard, scoreCard)
        XCTAssertEqual(game.players.first?.hand, playerHandFibonacci)
    }
    
    func testShouldNotStartARoundWithADuplicateStoryName() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let roundOne = try XCTUnwrap(game.rounds.last)
        let roundTwo = Round(storyName: roundOne.storyName)
        let playerOne = try XCTUnwrap(game.players.first)
        let chosenCard = try XCTUnwrap(playerOne.hand.first)
        
        // When
        try game.playACard(player: playerOne, card: chosenCard)
        
        // Then
        XCTAssertThrowsError(try game.startRound(round: roundTwo))
    }
    
    func testShouldNotStartARoundWhenLastRoundIsNotScored() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let roundTwo = Round(storyName: "Story Two")
        let playerOne = try XCTUnwrap(game.players.first)
        let chosenCard = try XCTUnwrap(playerOne.hand.first)
        
        // When
        try game.playACard(player: playerOne, card: chosenCard)
        
        // Then
        XCTAssertThrowsError(try game.startRound(round: roundTwo))
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
        let actualPlayerCard = game.findPlayerCard(expectedPlayerCard)
        
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
        let actualPlayerCard = try XCTUnwrap(game.findPlayerCard(expectedPlayerCard))
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
        let actualPlayerCard = try XCTUnwrap(game.findPlayerCard(expectedPlayerCard))
        XCTAssertEqual(game.playerCards.count, 2)
        XCTAssertEqual(actualPlayerCard, expectedPlayerCard)
    }
    
    func testShouldAppendReplacedCardInPlayerHand() throws {
        // Given
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playerTwo = try XCTUnwrap(game.players[1])
        let firstPlayingCard = try XCTUnwrap(playerOne.hand.first)
        let secondPlayingCard = try XCTUnwrap(playerOne.hand[1])
        
        // When: Player One replaces their played card with another one
        try game.playACard(player: playerOne, card: firstPlayingCard)
        try game.playACard(player: playerTwo, card: firstPlayingCard)
        try game.playACard(player: playerOne, card: secondPlayingCard)
        
        // Then: The first played card returns to Player One's hand as the second card is played
        let actualPlayer = try XCTUnwrap(game.players.first(where: { $0.name == playerOne.name }))
        XCTAssertEqual(actualPlayer.hand.count, 4)
        XCTAssertTrue(actualPlayer.hand.contains(firstPlayingCard))
        XCTAssertFalse(actualPlayer.hand.contains(secondPlayingCard))
        
    }
    
    func testShouldNotPlayACardWherePlayerIsNotInGame() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerTwo = Player(name: "Player Two")
        let playingCard = PlayingCard(faceValue: .one)
        
        // Then
        XCTAssertThrowsError(try game.playACard(player: playerTwo, card: playingCard))
    }
    
    // MARK: - Describe Replaying a Round
    
    func testShouldReplayCurrentRound() throws {
        // Setup
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let gameMasterHand = game.gameMaster.hand
        let playerOne = game.players[0]
        let playerTwo = game.players[1]
        let playerOneHand = playerOne.hand
        let playerTwoHand = playerTwo.hand
        let playerOneCard = try XCTUnwrap(playerOneHand.first)
        let playerTwoCard = try XCTUnwrap(playerTwoHand.last)

        // Given: All players have played a card
        try game.playACard(player: playerOne, card: playerOneCard)
        try game.playACard(player: playerTwo, card: playerTwoCard)

        // When: The game master replays the round
        try game.replayRound()
        
        // Then: Current round should not show ended
        let lastRound = try XCTUnwrap(game.lastRound)
        XCTAssertFalse(lastRound.hasEnded)
        
        // And: All played cards are removed form the game board
        XCTAssertTrue(game.playerCards.isEmpty)
        
        // And: The game master and all player hands are reset
        XCTAssertEqual(game.gameMaster.hand, gameMasterHand)
        XCTAssertEqual(game.players[0].hand, playerOneHand)
        XCTAssertEqual(game.players[1].hand, playerTwoHand)
    }
    
    func testShouldNotReplayARoundWhenThereAreNoRounds() {
        // Given: A game with no rounds
        let gameMaster = Player(name: "Game Master")
        var game = Game(gameMaster: gameMaster, pointScale: .linear)
        
        // When: Attempting to replay a round, Then: An error should be thown
        XCTAssertThrowsError(try game.replayRound())
    }
    
    func testShouldNotReplayARoundThatHasBeenScored() throws {
        // Setup
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = game.players[0]
        let playerTwo = game.players[1]
        let playerOneCard = try XCTUnwrap(playerOne.hand.first)
        let playerTwoCard = try XCTUnwrap(playerTwo.hand.last)
        let scoreCard = try XCTUnwrap(game.gameMaster.hand.first)

        // Given: All players have played a card and the round is scored
        try game.playACard(player: playerOne, card: playerOneCard)
        try game.playACard(player: playerTwo, card: playerTwoCard)
        try game.scoreRound(card: scoreCard)

        // When: The game master replays the round, Then: An error is thown
        XCTAssertThrowsError(try game.replayRound())
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
    
    // MARK: - Describe Scoring a Round
    
    func testShouldScoreTheLastRound() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playingCard = try XCTUnwrap(playerOne.hand.first)
        let scoreCard = try XCTUnwrap(game.gameMaster.hand.first)
        let lastRound = try XCTUnwrap(game.lastRound)
        
        // When
        try game.playACard(player: playerOne, card: playingCard)
        try game.scoreRound(card: scoreCard)
        
        // Then
        let scoredRound = try XCTUnwrap(game.findRound(lastRound))
        XCTAssertEqual(scoredRound, lastRound)
        XCTAssertEqual(scoredRound.scoreCard, scoreCard)
    }
    
    func testShouldClearPlayedCardsWhenRoundIsScored() throws {
        // Given
        var game = makeTwoPlayerGameInRoundOne(pointScale: .linear)
        let playerOne = try XCTUnwrap(game.players.first)
        let playerTwo = try XCTUnwrap(game.players[1])
        let playingCard = try XCTUnwrap(playerOne.hand.first)
        let scoreCard = try XCTUnwrap(game.gameMaster.hand.first)
        
        // When
        try game.playACard(player: playerOne, card: playingCard)
        try game.playACard(player: playerTwo, card: playingCard)
        try game.scoreRound(card: scoreCard)
        
        // Then
        XCTAssertEqual(game.playerCards.count, 0)
    }
    
    func testShouldNotBeScorableWhenNoRoundHasStarted() throws {
        // Given
        var game = makeOnePlayerGame(pointScale: .linear)
        let scoreCard = PlayingCard(faceValue: .one)
        
        // Then
        XCTAssertThrowsError(try game.scoreRound(card: scoreCard))
    }
    
    func testShouldNotBeScorableUntilLastRoundHasEnded() throws {
        // Given
        var game = makeOnePlayerGameInRoundOne(pointScale: .linear)
        let scoreCard = try XCTUnwrap(game.gameMaster.hand.first)
        
        // Then
        XCTAssertThrowsError(try game.scoreRound(card: scoreCard))
    }
}
