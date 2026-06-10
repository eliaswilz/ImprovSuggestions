import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class QuestionModeViewModelTests: XCTestCase {
    var appState: AppState!
    
    override func setUp() {
        appState = AppState()
    }
    
    func testFilteringQuestions() {
        let suggestions = [
            SuggestionItem(content: "Question 1", category: .question),
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Question 2", category: .question)
        ]
        
        appState.suggestions = suggestions
        
        XCTAssertEqual(appState.questions.count, 2)
        XCTAssertTrue(appState.questions.allSatisfy { $0.category == .question })
    }
    
    func testShowNextQuestion() {
        let suggestions = [
            SuggestionItem(content: "Question 1", category: .question),
            SuggestionItem(content: "Question 2", category: .question)
        ]
        
        appState.suggestions = suggestions
        let first = appState.currentQuestion
        
        appState.showNextQuestion()
        let second = appState.currentQuestion
        
        XCTAssertNotEqual(first?.id, second?.id)
    }
    
    func testToggleAudienceResponse() {
        XCTAssertFalse(appState.isShowingAudienceResponse)
        appState.toggleAudienceResponse()
        XCTAssertTrue(appState.isShowingAudienceResponse)
    }
}
