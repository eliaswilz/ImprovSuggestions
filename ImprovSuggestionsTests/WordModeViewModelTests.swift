import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class WordModeViewModelTests: XCTestCase {
    var appState: AppState!
    var container: ModelContainer!
    
    override func setUp() async throws {
        appState = AppState()
        container = try ModelContainer(for: SuggestionItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        appState.setModelContext(container.mainContext)
    }
    
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
    
    func testGenerateSuggestionClearsIfEmptyCategories() {
        appState.selectedCategories = []
        appState.generateWordSuggestion()
        XCTAssertNil(appState.currentSuggestion)
    }
}
