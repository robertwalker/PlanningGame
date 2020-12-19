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
    
    func testShouldNotCreateARoundWithABlankStoryName() {
        // When
        let round = Round(storyName: blankName)
        
        // Then
        XCTAssertNil(round)
    }
}
