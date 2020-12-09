import XCTest
@testable import App

final class PlayingCardTests: XCTestCase {
    
    // MARK: Describe Getting the Image Name
    
    func testShouldProvideQuestionCardImageName() {
        // When
        let card = PlayingCard(faceValue: .question)
        
        // Then
        XCTAssertEqual(card.imageName, "question_card.png")
    }

    func testShouldProvideOneCardImageName() {
        // When
        let card = PlayingCard(faceValue: .one)
        
        // Then
        XCTAssertEqual(card.imageName, "one_card.png")
    }

    func testShouldProvideTwoCardImageName() {
        // When
        let card = PlayingCard(faceValue: .two)
        
        // Then
        XCTAssertEqual(card.imageName, "two_card.png")
    }

    func testShouldProvideThreeCardImageName() {
        // When
        let card = PlayingCard(faceValue: .three)
        
        // Then
        XCTAssertEqual(card.imageName, "three_card.png")
    }

    func testShouldProvideFourCardImageName() {
        // When
        let card = PlayingCard(faceValue: .four)
        
        // Then
        XCTAssertEqual(card.imageName, "four_card.png")
    }

    func testShouldProvideFiveCardImageName() {
        // When
        let card = PlayingCard(faceValue: .five)
        
        // Then
        XCTAssertEqual(card.imageName, "five_card.png")
    }

    func testShouldProvideEightCardImageName() {
        // When
        let card = PlayingCard(faceValue: .eight)
        
        // Then
        XCTAssertEqual(card.imageName, "eight_card.png")
    }
    
    func testShouldProvideCardBackImageName() {
        // When
        let card = PlayingCard(faceValue: .one, isFaceDown: true)
        
        // Then
        XCTAssertEqual(card.imageName, "card_back.png")
    }
}
