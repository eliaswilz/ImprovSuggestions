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
}

@Model
final class SuggestionItem {
    @Attribute(.unique) var id: UUID
    var content: String
    var secondaryContent: String?
    var category: String
    var isFavorite: Bool
    var isCustom: Bool

    var categoryEnum: Category {
        Category(rawValue: category) ?? .question
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
        self.category = category.rawValue
        self.isFavorite = isFavorite
        self.isCustom = isCustom
    }
}
