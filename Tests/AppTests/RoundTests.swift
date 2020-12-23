import XCTest
@testable import App

final class RoundTests: XCTestCase {
    
    // MARK: - Describe Creating a Round
    
    func testShouldCreateARound() {
        // When
        let round = Round(storyName: "Round One")
        
        // Then
        XCTAssertNotNil(round)
    }
    
    func testShouldNotBeEnded() throws {
        // When
        let round = try XCTUnwrap(Round(storyName: "Round One"))
        
        // Then
        XCTAssertFalse(round.hasEnded)
    }

    func testShouldNotCreateARoundWithABlankStoryName() {
        // When
        let round = Round(storyName: blankName)
        
        // Then
        XCTAssertNil(round)
    }
    
    // MARK: Describe Ending a Round
    
    func testShouldEndTheRound() throws {
        // Given
        var round = try XCTUnwrap(Round(storyName: "Round One"))
        
        // When
        round.hasEnded = true
        
        // Then
        XCTAssertTrue(round.hasEnded)
    }
}
