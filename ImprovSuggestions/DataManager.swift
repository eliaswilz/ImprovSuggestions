import Foundation
import SwiftData

@MainActor
final class DataManager {
    static let shared = DataManager()

    private struct SeedEntry: Codable {
        let id: UUID
        let content: String
        let secondaryContent: String?
        let category: String
    }

    static var initialSuggestions: [SuggestionItem] {
        guard let url = Bundle.main.url(forResource: "seeds", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let entries = try? JSONDecoder().decode([SeedEntry].self, from: data) else {
            return []
        }
        return entries.map {
            SuggestionItem(
                id: $0.id,
                content: $0.content,
                secondaryContent: $0.secondaryContent,
                category: Category(rawValue: $0.category) ?? .question
            )
        }
    }

    private init() { }

    func preloadSuggestionsIfNeeded(modelContext: ModelContext) throws {
        let descriptor = FetchDescriptor<SuggestionItem>()

        try removeStalePlaceholderSuggestions(modelContext: modelContext)

        let existingSuggestions = try modelContext.fetch(descriptor)
        let brokenBuiltInSuggestions = existingSuggestions.filter { !$0.isCustom && $0.isMissingStoredCategory }

        for suggestion in brokenBuiltInSuggestions {
            modelContext.delete(suggestion)
        }

        let existingSeedIDs = Set(existingSuggestions.map(\.id))
        let missingInitialSuggestions = Self.initialSuggestions.filter { !existingSeedIDs.contains($0.id) }

        for suggestion in missingInitialSuggestions {
            modelContext.insert(suggestion)
        }

        if !brokenBuiltInSuggestions.isEmpty || !missingInitialSuggestions.isEmpty {
            try modelContext.save()
        }
    }

    private func removeStalePlaceholderSuggestions(modelContext: ModelContext) throws {
        let descriptor = FetchDescriptor<SuggestionItem>(
            predicate: #Predicate<SuggestionItem> { suggestion in
                suggestion.content == "New suggestion"
            }
        )
        let placeholders = try modelContext.fetch(descriptor)

        for placeholder in placeholders {
            modelContext.delete(placeholder)
        }

        if !placeholders.isEmpty {
            try modelContext.save()
        }
    }

    func resetAppData(suggestions: [SuggestionItem], modelContext: ModelContext, alertManager: PersistenceAlertManager) {
        for suggestion in suggestions {
            if suggestion.isCustom {
                modelContext.delete(suggestion)
            }
        }

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            alertManager.showSaveError(
                action: "Your app data could not be reset.",
                error: error
            )
        }
    }

    func addCustomSuggestion(
        content: String,
        category: Category,
        modelContext: ModelContext,
        alertManager: PersistenceAlertManager
    ) {
        let suggestion = SuggestionItem(
            content: content,
            category: category,
            isCustom: true
        )
        modelContext.insert(suggestion)

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            alertManager.showSaveError(
                action: "Your custom suggestion could not be saved.",
                error: error
            )
        }
    }
}
