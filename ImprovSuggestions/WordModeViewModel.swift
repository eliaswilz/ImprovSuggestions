import Foundation
import SwiftData
import SwiftUI
import Observation

@Observable
@MainActor
final class WordModeViewModel {
    var selectedCategories: Set<Category> = [.object]
    var currentSuggestion: SuggestionItem?
    var longPressedCategory: Category?
    var suggestions: [SuggestionItem] = []
    
    private var suggestionQueueManagers: [String: SuggestionQueueManager] = [:]
    private var modelContext: ModelContext?
    
    let selectableCategories: [Category] = [.object, .location, .profession, .emotion]
    
    var filteredSuggestions: [SuggestionItem] {
        suggestions.filter { selectedCategories.contains($0.category) && !$0.isMissingStoredCategory }
    }
    
    var selectedCategoryLabel: String {
        guard !selectedCategories.isEmpty else { return "No Categories Selected" }
        
        return selectableCategories
            .filter { selectedCategories.contains($0) }
            .map(\.displayName)
            .joined(separator: ", ")
    }
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func updateSuggestions(_ suggestions: [SuggestionItem]) {
        self.suggestions = suggestions
        if currentSuggestion == nil || !selectedCategories.contains(currentSuggestion?.category ?? .question) {
            generateSuggestion()
        }
    }
    
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
    
    func generateSuggestion() {
        guard !selectedCategories.isEmpty else {
            currentSuggestion = nil
            return
        }
        
        let categoryKey = selectableCategories
            .filter { selectedCategories.contains($0) }
            .map(\.rawValue)
            .joined(separator: "|")
        
        var queueManager = suggestionQueueManagers[categoryKey] ?? SuggestionQueueManager()
        currentSuggestion = queueManager.next(from: filteredSuggestions)
        suggestionQueueManagers[categoryKey] = queueManager
    }
    
    func toggleFavorite(persistenceAlertManager: PersistenceAlertManager) {
        guard let currentSuggestion, let modelContext else { return }
        DataManager.shared.toggleFavorite(
            suggestion: currentSuggestion,
            modelContext: modelContext,
            alertManager: persistenceAlertManager
        )
    }
}
