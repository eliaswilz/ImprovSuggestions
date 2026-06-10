import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class AppStateTests: XCTestCase {
    var appState: AppState!
    var container: ModelContainer!
    
    override func setUp() async throws {
        appState = AppState()
        container = try ModelContainer(for: SuggestionItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        appState.setModelContext(container.mainContext)
    }
    
    // MARK: - Word Mode Tests
    func testFilteringByCategory() {
        let suggestions = [
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Location 1", category: .location),
            SuggestionItem(content: "Object 2", category: .object)
        ]
        
        appState.suggestions = suggestions
        appState.selectedCategories = [.object]
        
        XCTAssertEqual(appState.filteredWordSuggestions.count, 2)
        XCTAssertTrue(appState.filteredWordSuggestions.allSatisfy { $0.category == .object })
    }
    
    func testMultiCategoryFiltering() {
        let suggestions = [
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Location 1", category: .location),
            SuggestionItem(content: "Profession 1", category: .profession)
        ]
        
        appState.suggestions = suggestions
        appState.selectedCategories = [.object, .location]
        
        XCTAssertEqual(appState.filteredWordSuggestions.count, 2)
    }
    
    func testToggleCategory() {
        XCTAssertTrue(appState.selectedCategories.contains(.object))
        
        appState.toggleCategory(.object)
        XCTAssertFalse(appState.selectedCategories.contains(.object))
        
        appState.toggleCategory(.object)
        XCTAssertTrue(appState.selectedCategories.contains(.object))
    }
    
    func testSelectOnlyCategory() {
        appState.selectedCategories = [.object, .location]
        
        appState.selectOnlyCategory(.profession)
        
        XCTAssertEqual(appState.selectedCategories.count, 1)
        XCTAssertTrue(appState.selectedCategories.contains(.profession))
    }
    
    func testGenerateWordSuggestionClearsIfEmptyCategories() {
        appState.selectedCategories = []
        appState.generateWordSuggestion()
        XCTAssertNil(appState.currentSuggestion)
    }

    // MARK: - Question Mode Tests
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

    // MARK: - Game Mode Tests
    func testGameSelection() {
        XCTAssertEqual(appState.selectedGame, .firstLineLastLine)
        
        appState.selectGame(.changingEmotions)
        XCTAssertEqual(appState.selectedGame, .changingEmotions)
    }
    
    func testRegenerateFirstLineLastLine() {
        let suggestions = [
            SuggestionItem(content: "First", category: .dialogue),
            SuggestionItem(content: "Last", category: .dialogue)
        ]
        
        appState.suggestions = suggestions
        appState.selectGame(.firstLineLastLine)
        
        XCTAssertNotNil(appState.firstLine)
        XCTAssertNotNil(appState.lastLine)
        XCTAssertNotEqual(appState.firstLine?.id, appState.lastLine?.id)
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
