import XCTest
import SwiftData
@testable import ImprovSuggestions

@MainActor
final class QuestionModeViewModelTests: XCTestCase {
    var viewModel: QuestionModeViewModel!
    
    override func setUp() {
        viewModel = QuestionModeViewModel()
    }
    
    func testFilteringQuestions() {
        let suggestions = [
            SuggestionItem(content: "Question 1", category: .question),
            SuggestionItem(content: "Object 1", category: .object),
            SuggestionItem(content: "Question 2", category: .question)
        ]
        
        viewModel.updateSuggestions(suggestions)
        
        XCTAssertEqual(viewModel.questions.count, 2)
        XCTAssertTrue(viewModel.questions.allSatisfy { $0.category == .question })
    }
    
    func testShowNextQuestion() {
        let suggestions = [
            SuggestionItem(content: "Question 1", category: .question),
            SuggestionItem(content: "Question 2", category: .question)
        ]
        
        viewModel.updateSuggestions(suggestions)
        let first = viewModel.currentQuestion
        
        viewModel.showNextQuestion()
        let second = viewModel.currentQuestion
        
        XCTAssertNotEqual(first?.id, second?.id)
    }
    
    func testToggleAudienceResponse() {
        XCTAssertFalse(viewModel.isShowingAudienceResponse)
        viewModel.toggleAudienceResponse()
        XCTAssertTrue(viewModel.isShowingAudienceResponse)
    }
}
