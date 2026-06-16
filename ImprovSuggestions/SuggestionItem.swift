import Foundation
import SwiftData

enum Category: Codable, CaseIterable, Identifiable, RawRepresentable {
    case question
    case object
    case location
    case profession
    case emotion
    case celebrity
    case dialogue

    var id: String { rawValue }

    var rawValue: String {
        switch self {
        case .question: "question"
        case .object: "object"
        case .location: "location"
        case .profession: "profession"
        case .emotion: "emotion"
        case .celebrity: "celebrity"
        case .dialogue: "dialogue"
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "question": self = .question
        case "object": self = .object
        case "location": self = .location
        case "profession": self = .profession
        case "emotion": self = .emotion
        case "celebrity": self = .celebrity
        case "dialogue", "dialogueLine": self = .dialogue
        default: return nil
        }
    }

    var displayName: String {
        switch self {
        case .question:
            "Question"
        case .object:
            "Object"
        case .location:
            "Location"
        case .profession:
            "Profession"
        case .emotion:
            "Emotion"
        case .celebrity:
            "Celebrity"
        case .dialogue:
            "Dialogue"
        }
    }
}

@Model
final class SuggestionItem {
    @Attribute(.unique) var id: UUID
    var content: String
    var secondaryContent: String?
    private var storedCategory: Category?
    var isFavorite: Bool

    var category: Category {
        get { storedCategory ?? .question }
        set { storedCategory = newValue }
    }

    var isMissingStoredCategory: Bool {
        storedCategory == nil
    }

    func matchesCategory(_ category: Category) -> Bool {
        storedCategory == category
    }

    init(
        id: UUID = UUID(),
        content: String,
        secondaryContent: String? = nil,
        category: Category,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.content = content
        self.secondaryContent = secondaryContent
        self.storedCategory = category
        self.isFavorite = isFavorite
    }
}
