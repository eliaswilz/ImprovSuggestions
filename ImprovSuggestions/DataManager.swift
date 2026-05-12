import Foundation
import SwiftData

@MainActor
final class DataManager {
    static let shared = DataManager()

    static let initialSuggestions: [SuggestionItem] = [
        SuggestionItem(content: "What secret have you been keeping from your roommate?", category: .question),
        SuggestionItem(content: "Why did the mayor ban music after sunset?", category: .question),
        SuggestionItem(content: "Who keeps calling the landline in the basement?", category: .question),
        SuggestionItem(content: "What would make this family dinner even more awkward?", category: .question),
        SuggestionItem(content: "Why is everyone pretending not to notice the penguin?", category: .question),
        SuggestionItem(content: "How did you lose the company mascot?", category: .question),
        SuggestionItem(content: "What is the one rule aboard this spaceship?", category: .question),
        SuggestionItem(content: "Why did you bring a ladder to a job interview?", category: .question),
        SuggestionItem(content: "a suspiciously heavy briefcase", category: .object),
        SuggestionItem(content: "a singing toaster", category: .object),
        SuggestionItem(content: "a family heirloom snow globe", category: .object),
        SuggestionItem(content: "an umbrella that only opens indoors", category: .object),
        SuggestionItem(content: "a cookbook written in invisible ink", category: .object),
        SuggestionItem(content: "a trophy for worst customer service", category: .object),
        SuggestionItem(content: "a bouquet of plastic roses", category: .object),
        SuggestionItem(content: "a haunted GPS device", category: .object),
        SuggestionItem(content: "an abandoned amusement park", category: .location),
        SuggestionItem(content: "the break room of a luxury hotel", category: .location),
        SuggestionItem(content: "a submarine gift shop", category: .location),
        SuggestionItem(content: "the waiting room outside a dragon's dentist", category: .location),
        SuggestionItem(content: "a rooftop garden during a thunderstorm", category: .location),
        SuggestionItem(content: "a tiny town's only escalator", category: .location),
        SuggestionItem(content: "a museum of failed inventions", category: .location),
        SuggestionItem(content: "the backstage area of a children's talent show", category: .location),
        SuggestionItem(content: "wedding planner for monsters", category: .profession),
        SuggestionItem(content: "professional apology writer", category: .profession),
        SuggestionItem(content: "undercover librarian", category: .profession),
        SuggestionItem(content: "competitive dog groomer", category: .profession),
        SuggestionItem(content: "fortune cookie editor", category: .profession),
        SuggestionItem(content: "volcano tour guide", category: .profession),
        SuggestionItem(content: "alien etiquette coach", category: .profession),
        SuggestionItem(content: "retired superhero accountant", category: .profession),
        SuggestionItem(content: "overjoyed but trying to seem professional", category: .emotion),
        SuggestionItem(content: "quietly jealous", category: .emotion),
        SuggestionItem(content: "unreasonably confident", category: .emotion),
        SuggestionItem(content: "nostalgic for something that happened yesterday", category: .emotion),
        SuggestionItem(content: "terrified of disappointing a child", category: .emotion),
        SuggestionItem(content: "deeply offended by a compliment", category: .emotion),
        SuggestionItem(content: "suspiciously calm", category: .emotion),
        SuggestionItem(content: "furious but whispering", category: .emotion),
        SuggestionItem(content: "I told you not to press the red button.", secondaryContent: "It was glowing at me.", category: .dialogueLine),
        SuggestionItem(content: "This is not how my grandmother described treasure hunting.", secondaryContent: "Your grandmother had a very selective memory.", category: .dialogueLine),
        SuggestionItem(content: "If anyone asks, we were never in the aquarium.", secondaryContent: "Then why am I holding a seahorse?", category: .dialogueLine),
        SuggestionItem(content: "The ceremony starts in five minutes and the rings are missing.", secondaryContent: "Define missing.", category: .dialogueLine),
        SuggestionItem(content: "I finally translated the note from the future.", secondaryContent: "Does it mention lunch?", category: .dialogueLine),
        SuggestionItem(content: "You promised the robot it could be best man.", secondaryContent: "It caught the bouquet fair and square.", category: .dialogueLine),
        SuggestionItem(content: "I cannot believe you invited my nemesis to brunch.", secondaryContent: "Technically, he RSVP'd as plus one.", category: .dialogueLine),
        SuggestionItem(content: "The ghost says we are using the wrong cheese.", secondaryContent: "The ghost has always been dramatic about fondue.", category: .dialogueLine),
        SuggestionItem(content: "What did the audience just shout from the balcony?", secondaryContent: "A llama with a law degree!", category: .question),
        SuggestionItem(content: "Give me a place where two people should never break up.", secondaryContent: "Inside a revolving door.", category: .location)
    ]

    private init() { }

    func preloadSuggestionsIfNeeded(modelContext: ModelContext) throws {
        let descriptor = FetchDescriptor<SuggestionItem>()

        try removeStalePlaceholderSuggestions(modelContext: modelContext)

        let existingSuggestions = try modelContext.fetch(descriptor)
        let brokenBuiltInSuggestions = existingSuggestions.filter { !$0.isCustom && $0.isMissingStoredCategory }

        for suggestion in brokenBuiltInSuggestions {
            modelContext.delete(suggestion)
        }

        let existingSeedContents = Set(
            existingSuggestions
                .filter { !$0.isMissingStoredCategory }
                .map(\.content)
        )
        let missingInitialSuggestions = Self.initialSuggestions.filter { !existingSeedContents.contains($0.content) }

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
}
