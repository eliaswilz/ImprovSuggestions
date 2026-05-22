import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class GameModeViewModelTests: XCTestCase {
    var viewModel: GameModeViewModel!
    
    override func setUp() {
        viewModel = GameModeViewModel()
    }
    
    func testGameSelection() {
        XCTAssertEqual(viewModel.selectedGame, .firstLineLastLine)
        
        viewModel.selectGame(.changingEmotions)
        XCTAssertEqual(viewModel.selectedGame, .changingEmotions)
    }
    
    func testRegenerateFirstLineLastLine() {
        let suggestions = [
            SuggestionItem(content: "First", secondaryContent: "Last", category: .dialogueLine)
        ]
        
        viewModel.updateSuggestions(suggestions)
        viewModel.selectGame(.firstLineLastLine)
        
        XCTAssertNotNil(viewModel.dialogueLine)
        XCTAssertEqual(viewModel.dialogueLine?.content, "First")
        XCTAssertEqual(viewModel.dialogueLine?.secondaryContent, "Last")
    }
    
    func testRegenerateChangingEmotions() {
        var suggestions: [SuggestionItem] = []
        for i in 1...20 {
            suggestions.append(SuggestionItem(content: "Emotion \(i)", category: .emotion))
        }
        
        viewModel.updateSuggestions(suggestions)
        viewModel.selectGame(.changingEmotions)
        
        XCTAssertEqual(viewModel.emotions.count, 15)
        XCTAssertTrue(viewModel.emotions.allSatisfy { $0.category == .emotion })
    }
}
