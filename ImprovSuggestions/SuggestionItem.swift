import Foundation
import SwiftData

enum Category: String, Codable, CaseIterable, Identifiable {
    case question
    case object
    case location
    case profession
    case emotion
    case dialogueLine

    var id: String { rawValue }

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
        case .dialogueLine:
            "Dialogue Line"
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
    var isCustom: Bool

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
        isFavorite: Bool = false,
        isCustom: Bool = false
    ) {
        self.id = id
        self.content = content
        self.secondaryContent = secondaryContent
        self.storedCategory = category
        self.isFavorite = isFavorite
        self.isCustom = isCustom
    }
}
