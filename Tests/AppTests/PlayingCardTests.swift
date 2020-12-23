import XCTest
@testable import App

final class PlayingCardTests: XCTestCase {
    
    // MARK: Describe Equatable Conformance
    
    func testShouldBeEqualAllPropertiesAreEqual() {
        // Given
        let firstCard = PlayingCard(faceValue: .one)
        let secondCard = PlayingCard(faceValue: .one)
        
        // Then
        XCTAssertEqual(secondCard, firstCard)
    }
    
    func testShouldBeEqualWhenOnlyFaceValueIsEqual() {
        // Given
        let firstCard = PlayingCard(faceValue: .one, isFaceDown: false)
        let secondCard = PlayingCard(faceValue: .one, isFaceDown: true)
        
        // Then
        XCTAssertEqual(secondCard, firstCard)
    }
    
    func testShouldNotBeEqualWhenFaceValueIsDifferent() {
        // Given
        let firstCard = PlayingCard(faceValue: .one)
        let secondCard = PlayingCard(faceValue: .two)
        
        // Then
        XCTAssertNotEqual(secondCard, firstCard)
    }
}
