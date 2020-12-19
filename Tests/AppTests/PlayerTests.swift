import XCTest
@testable import App

final class PlayerTests: XCTestCase {
    
    // MARK: - Describe Creating a Player
    
    func testShouldCreateAPlayer() {
        // When
        let player = Player(name: "Player One")
        
        // Then
        XCTAssertNotNil(player)
    }
    
    func testShouldNotCreateAPlayerWithABlankName() {
        // When
        let player = Player(name: blankName)
        
        // Then
        XCTAssertNil(player)
    }
}
