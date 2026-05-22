import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class WordModeViewModelTests: XCTestCase {
    var viewModel: WordModeViewModel!
    var container: ModelContainer!
    
    override func setUp() async throws {
        viewModel = WordModeViewModel()
        container = try ModelContainer(for: SuggestionItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        viewModel.setModelContext(container.mainContext)
    }
    
    func testFilteringByCategory() {
        let suggestions = [
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Location 1", category: .location),
            SuggestionItem(content: "Object 2", category: .object)
        ]
        
        viewModel.updateSuggestions(suggestions)
        viewModel.selectedCategories = [.object]
        
        XCTAssertEqual(viewModel.filteredSuggestions.count, 2)
        XCTAssertTrue(viewModel.filteredSuggestions.allSatisfy { $0.category == .object })
    }
    
    func testMultiCategoryFiltering() {
        let suggestions = [
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Location 1", category: .location),
            SuggestionItem(content: "Profession 1", category: .profession)
        ]
        
        viewModel.updateSuggestions(suggestions)
        viewModel.selectedCategories = [.object, .location]
        
        XCTAssertEqual(viewModel.filteredSuggestions.count, 2)
    }
    
    func testToggleCategory() {
        XCTAssertTrue(viewModel.selectedCategories.contains(.object))
        
        viewModel.toggleCategory(.object)
        XCTAssertFalse(viewModel.selectedCategories.contains(.object))
        
        viewModel.toggleCategory(.object)
        XCTAssertTrue(viewModel.selectedCategories.contains(.object))
    }
    
    func testSelectOnlyCategory() {
        viewModel.selectedCategories = [.object, .location]
        
        viewModel.selectOnlyCategory(.profession)
        
        XCTAssertEqual(viewModel.selectedCategories.count, 1)
        XCTAssertTrue(viewModel.selectedCategories.contains(.profession))
    }
    
    func testGenerateSuggestionClearsIfEmptyCategories() {
        viewModel.selectedCategories = []
        viewModel.generateSuggestion()
        XCTAssertNil(viewModel.currentSuggestion)
    }
}
