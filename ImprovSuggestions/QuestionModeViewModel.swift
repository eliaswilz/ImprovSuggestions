import Foundation
import SwiftData
import SwiftUI
import Observation

@Observable
@MainActor
final class QuestionModeViewModel {
    var currentQuestion: SuggestionItem?
    var isShowingAudienceResponse = false
    var suggestions: [SuggestionItem] = []
    
    private var questionQueueManager = SuggestionQueueManager()
    
    var questions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.question) }
    }
    
    func updateSuggestions(_ suggestions: [SuggestionItem]) {
        self.suggestions = suggestions
        if currentQuestion == nil {
            showNextQuestion()
        }
    }
    
    func showNextQuestion() {
        currentQuestion = questionQueueManager.next(from: questions)
        isShowingAudienceResponse = false
    }
    
    func toggleAudienceResponse() {
        isShowingAudienceResponse = true
    }
}
