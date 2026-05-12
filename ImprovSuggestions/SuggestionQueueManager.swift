import Foundation

struct SuggestionQueueManager {
    private var queue: [SuggestionItem] = []
    private var previousItemID: UUID?

    mutating func next(from suggestions: [SuggestionItem]) -> SuggestionItem? {
        guard !suggestions.isEmpty else {
            queue.removeAll()
            previousItemID = nil
            return nil
        }

        refillIfNeeded(from: suggestions)

        var nextItem = queue.popLast()

        if suggestions.count > 1, nextItem?.id == previousItemID {
            if queue.isEmpty {
                queue = suggestions.filter { $0.id != previousItemID }.shuffled()
            }

            nextItem = queue.popLast() ?? nextItem
        }

        previousItemID = nextItem?.id
        return nextItem
    }

    mutating func reset() {
        queue.removeAll()
        previousItemID = nil
    }

    private mutating func refillIfNeeded(from suggestions: [SuggestionItem]) {
        let suggestionIDs = Set(suggestions.map(\.id))
        let queueContainsUnavailableItem = queue.contains { !suggestionIDs.contains($0.id) }

        if queue.isEmpty || queueContainsUnavailableItem {
            queue = suggestions.shuffled()
        }
    }
}
