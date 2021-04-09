import XCTest
@testable import PlanningGame

final class PlayingCardTests: XCTestCase {
    
    // MARK: Describe Equatable Conformance
    
    func testShouldBeEqualWhenAllPropertiesAreEqual() {
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
    
    func testShouldMapFaceValuesToPointValues() {
        let valueMap: [FaceValue:Int] = [.question:0, .one:1, .two:2, .three:3, .four:4, .five:5, .eight:8]
        for (faceValue, PointValue) in valueMap {
            assertPointValue(faceValue: faceValue, pointValue: PointValue)
        }
    }

    // MARK: Parameterized Tests
    
    private func assertPointValue(faceValue: FaceValue, pointValue: Int) {
        // Given
        let card = PlayingCard(faceValue: faceValue)
        
        // Then
        XCTAssertEqual(card.faceValue.pointValue, pointValue)
    }
}
