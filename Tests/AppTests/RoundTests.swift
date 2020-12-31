import XCTest
@testable import App

final class RoundTests: XCTestCase {
    
    // MARK: - Describe Creating a Round
    
    func testShouldCreateARound() {
        // When
        let round = Round(storyName: "Round One")
        
        // Then
        XCTAssertEqual(round.storyName, "Round One")
    }
    
    func testShouldNotBeEnded() throws {
        // When
        let round = try XCTUnwrap(Round(storyName: "Round One"))
        
        // Then
        XCTAssertFalse(round.hasEnded)
    }

    func testShouldHaveAQuestionScoreCard() {
        // Given
        let scoreCard = PlayingCard(faceValue: .question)
        
        // When
        let round = Round(storyName: "Round One")
        
        // Then
        XCTAssertEqual(round.scoreCard, scoreCard)
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
    
    // MARK: Describe Equatable Conformance
    
    func testShouldEqualWhenAllPropertiesAreEqual() throws {
        // Given
        let roundOne = try XCTUnwrap(Round(storyName: "Round One"))
        let roundOneCopy = try XCTUnwrap(Round(storyName: "Round One"))
        
        // Then
        XCTAssertEqual(roundOne, roundOneCopy)
    }
    
    func testShouldBeEqualWhenStoryNamesAreTheSame() throws {
        // Given
        var roundOne = try XCTUnwrap(Round(storyName: "Round One"))
        var roundOneCopy = try XCTUnwrap(Round(storyName: "Round One"))
        roundOne.scoreCard = PlayingCard(faceValue: .one)
        roundOneCopy.scoreCard = PlayingCard(faceValue: .two)
        
        // Then
        XCTAssertEqual(roundOne, roundOneCopy)
    }
    
    func testShouldNotBeEqualWhenStoryNamesAreDifferent() throws {
        // Given
        let roundOne = try XCTUnwrap(Round(storyName: "Round One"))
        let roundTwo = try XCTUnwrap(Round(storyName: "Round Two"))
        
        // Then
        XCTAssertNotEqual(roundOne, roundTwo)
    }
}
