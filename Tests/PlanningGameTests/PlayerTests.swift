import XCTest
@testable import PlanningGame

final class PlayerTests: XCTestCase {
    
    // MARK: - Describe Creating a Player
    
    func testShouldCreateAPlayer() {
        // When
        let player = Player(name: "Player One")
        
        // Then
        XCTAssertEqual(player.name, "Player One")
    }
    
    func testShouldHaveAnEmptyHand() {
        // When
        let player = Player(name: "Player One")
        
        // Then
        XCTAssertEqual(player.hand.count, 0)
    }
    
    // MARK: - Describe Equatable Conformance
    
    func testShouldBeEqualWhenNamesMatch() {
        // Given
        let playerOne = Player(name: "Same Name")
        let playerTwo = Player(name: "Same Name")
        
        // Then
        XCTAssertTrue(playerOne == playerTwo)
    }
    
    func testShouldBeEqualWhenNamesMatchWithDifferentCase() {
        // Given
        let playerOne = Player(name: "SAME NAME")
        let playerTwo = Player(name: "same name")
        
        // Then
        XCTAssertTrue(playerOne == playerTwo)
    }
    
    func testShouldBeEqualWhenNamesMatchWithDifferentHands() {
        // Given
        var playerOne = Player(name: "Same Name")
        var playerTwo = Player(name: "Same Name")

        // When
        playerOne.hand = [PlayingCard(faceValue: .one)]
        playerTwo.hand = [PlayingCard(faceValue: .one), PlayingCard(faceValue: .two)]
        
        // Then
        XCTAssertTrue(playerOne == playerTwo)
    }
    
    func testShoudNotBeEqualWhenNamesAreDifferent() {
        // Given
        let playerOne = Player(name: "Player One")
        let playerTwo = Player(name: "Player Two")
        
        // Then
        XCTAssertFalse(playerOne == playerTwo)
    }
}
