import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class GameModeViewModelTests: XCTestCase {
    var appState: AppState!
    
    override func setUp() {
        appState = AppState()
    }
    
    func testGameSelection() {
        XCTAssertEqual(appState.selectedGame, .firstLineLastLine)
        
        appState.selectGame(.changingEmotions)
        XCTAssertEqual(appState.selectedGame, .changingEmotions)
    }
    
    func testRegenerateFirstLineLastLine() {
        let suggestions = [
            SuggestionItem(content: "First", secondaryContent: "Last", category: .dialogueLine)
        ]
        
        appState.suggestions = suggestions
        appState.selectGame(.firstLineLastLine)
        
        XCTAssertNotNil(appState.dialogueLine)
        XCTAssertEqual(appState.dialogueLine?.content, "First")
        XCTAssertEqual(appState.dialogueLine?.secondaryContent, "Last")
    }
    
    func testRegenerateChangingEmotions() {
        var suggestions: [SuggestionItem] = []
        for i in 1...20 {
            suggestions.append(SuggestionItem(content: "Emotion \(i)", category: .emotion))
        }
        
        appState.suggestions = suggestions
        appState.selectGame(.changingEmotions)
        
        XCTAssertEqual(appState.emotions.count, 15)
        XCTAssertTrue(appState.emotions.allSatisfy { $0.category == .emotion })
    }
}
