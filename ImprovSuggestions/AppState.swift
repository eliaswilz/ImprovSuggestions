import Foundation
import SwiftData
import SwiftUI
import Observation

@Observable
@MainActor
final class AppState {
    // MARK: - Shared State
    private var modelContext: ModelContext?
    var suggestions: [SuggestionItem] = [] {
        didSet {
            updateAllModes()
        }
    }

    // MARK: - Word Mode State
    var selectedCategories: Set<Category> = [.object]
    var currentSuggestion: SuggestionItem?
    var longPressedCategory: Category?
    private var wordQueueManagers: [String: SuggestionQueueManager] = [:]
    let selectableWordCategories: [Category] = [.object, .location, .profession, .emotion]
    
    var filteredWordSuggestions: [SuggestionItem] {
        suggestions.filter { selectedCategories.contains($0.category) && !$0.isMissingStoredCategory }
    }
    
    var selectedCategoryLabel: String {
        guard !selectedCategories.isEmpty else { return "No Categories Selected" }
        
        return selectableWordCategories
            .filter { selectedCategories.contains($0) }
            .map(\.displayName)
            .joined(separator: ", ")
    }

    // MARK: - Question Mode State
    var currentQuestion: SuggestionItem?
    var isShowingAudienceResponse = false
    private var questionQueueManager = SuggestionQueueManager()
    
    var questions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.question) }
    }

    // MARK: - Game Mode State
    enum GameMode: String, CaseIterable, Identifiable {
        case firstLineLastLine = "First Line, Last Line"
        case changingEmotions = "Changing Emotions"
        
        var id: String { rawValue }
    }
    
    var selectedGame: GameMode = .firstLineLastLine
    var firstLine: SuggestionItem?
    var lastLine: SuggestionItem?
    var emotions: [SuggestionItem] = []
    private var dialogueQueueManager = SuggestionQueueManager()
    
    private var dialogueLines: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.dialogue) }
    }
    
    private var emotionSuggestions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.emotion) }
    }

    // MARK: - Initialization & Lifecycle
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }

    private func updateAllModes() {
        // Update Word Mode
        if currentSuggestion == nil || !selectedCategories.contains(currentSuggestion?.category ?? .question) {
            generateWordSuggestion()
        }
        
        // Update Question Mode
        if currentQuestion == nil {
            showNextQuestion()
        }
        
        // Update Game Mode
        if emotions.isEmpty || firstLine == nil || lastLine == nil {
            regenerateCurrentGame()
        }
    }

    // MARK: - Word Mode Methods
    func toggleCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    func selectOnlyCategory(_ category: Category) {
        if selectedCategories.subtracting([category]).isEmpty == false {
            HapticManager.impact(.medium)
        }
        selectedCategories = [category]
    }
    
    func generateWordSuggestion() {
        guard !selectedCategories.isEmpty else {
            currentSuggestion = nil
            return
        }
        
        let categoryKey = selectableWordCategories
            .filter { selectedCategories.contains($0) }
            .map(\.rawValue)
            .joined(separator: "|")
        
        var queueManager = wordQueueManagers[categoryKey] ?? SuggestionQueueManager()
        currentSuggestion = queueManager.next(from: filteredWordSuggestions)
        wordQueueManagers[categoryKey] = queueManager
    }

    // MARK: - Question Mode Methods
    func showNextQuestion() {
        currentQuestion = questionQueueManager.next(from: questions)
        isShowingAudienceResponse = false
    }
    
    func toggleAudienceResponse() {
        isShowingAudienceResponse = true
    }

    // MARK: - Game Mode Methods
    func selectGame(_ game: GameMode) {
        selectedGame = game
        regenerateCurrentGame()
    }
    
    func regenerateCurrentGame() {
        switch selectedGame {
        case .firstLineLastLine:
            firstLine = dialogueQueueManager.next(from: dialogueLines)
            // Pick a different line for the last line
            let remainingLines = dialogueLines.filter { $0.id != firstLine?.id }
            lastLine = remainingLines.shuffled().first
        case .changingEmotions:
            emotions = Array(emotionSuggestions.shuffled().prefix(15))
        }
    }
}
