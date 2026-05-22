import Foundation
import SwiftData
import SwiftUI
import Observation

@Observable
@MainActor
final class GameModeViewModel {
    enum GameMode: String, CaseIterable, Identifiable {
        case firstLineLastLine = "First Line, Last Line"
        case changingEmotions = "Changing Emotions"
        
        var id: String { rawValue }
    }
    
    var selectedGame: GameMode = .firstLineLastLine
    var dialogueLine: SuggestionItem?
    var emotions: [SuggestionItem] = []
    var suggestions: [SuggestionItem] = []
    
    private var dialogueLineQueueManager = SuggestionQueueManager()
    
    private var dialogueLines: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.dialogueLine) }
    }
    
    private var emotionSuggestions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.emotion) }
    }
    
    func updateSuggestions(_ suggestions: [SuggestionItem]) {
        self.suggestions = suggestions
        if emotions.isEmpty || dialogueLine == nil {
            regenerateCurrentGame()
        }
    }
    
    func selectGame(_ game: GameMode) {
        selectedGame = game
        regenerateCurrentGame()
    }
    
    func regenerateCurrentGame() {
        switch selectedGame {
        case .firstLineLastLine:
            dialogueLine = dialogueLineQueueManager.next(from: dialogueLines)
        case .changingEmotions:
            emotions = Array(emotionSuggestions.shuffled().prefix(15))
        }
    }
}
