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
        SuggestionItem(content: "Joy", secondaryContent: "A feeling of great pleasure and happiness", category: .emotion),
        SuggestionItem(content: "Sadness", secondaryContent: "A state of sorrow or unhappiness", category: .emotion),
        SuggestionItem(content: "Anger", secondaryContent: "A strong feeling of displeasure or hostility", category: .emotion),
        SuggestionItem(content: "Fear", secondaryContent: "An unpleasant emotion caused by perceived danger or threat", category: .emotion),
        SuggestionItem(content: "Surprise", secondaryContent: "A feeling caused by something unexpected or sudden", category: .emotion),
        SuggestionItem(content: "Disgust", secondaryContent: "A strong sense of revulsion or aversion", category: .emotion),
        SuggestionItem(content: "Anticipation", secondaryContent: "Excitement or anxiety about a future event", category: .emotion),
        SuggestionItem(content: "Trust", secondaryContent: "A feeling of confidence and reliance in someone or something", category: .emotion),
        SuggestionItem(content: "Love", secondaryContent: "A deep affection and attachment toward someone", category: .emotion),
        SuggestionItem(content: "Guilt", secondaryContent: "A feeling of responsibility or remorse for a wrongdoing", category: .emotion),
        SuggestionItem(content: "Shame", secondaryContent: "A painful sense of humiliation or distress over one's actions", category: .emotion),
        SuggestionItem(content: "Pride", secondaryContent: "Satisfaction derived from one's own achievements or qualities", category: .emotion),
        SuggestionItem(content: "Envy", secondaryContent: "Resentment toward someone else's advantages or possessions", category: .emotion),
        SuggestionItem(content: "Jealousy", secondaryContent: "Fear of losing something valued to a rival", category: .emotion),
        SuggestionItem(content: "Gratitude", secondaryContent: "A warm feeling of thankfulness toward others", category: .emotion),
        SuggestionItem(content: "Awe", secondaryContent: "An overwhelming sense of wonder and reverence", category: .emotion),
        SuggestionItem(content: "Contempt", secondaryContent: "A feeling of disdain or superiority over others", category: .emotion),
        SuggestionItem(content: "Loneliness", secondaryContent: "A sense of isolation and lack of connection", category: .emotion),
        SuggestionItem(content: "Boredom", secondaryContent: "A state of weariness from lack of interest or stimulation", category: .emotion),
        SuggestionItem(content: "Curiosity", secondaryContent: "A strong desire to know or learn something", category: .emotion),
        SuggestionItem(content: "Compassion", secondaryContent: "Sympathetic concern for the suffering of others", category: .emotion),
        SuggestionItem(content: "Nostalgia", secondaryContent: "A sentimental longing for the past", category: .emotion),
        SuggestionItem(content: "Anxiety", secondaryContent: "A feeling of worry, nervousness, or unease", category: .emotion),
        SuggestionItem(content: "Serenity", secondaryContent: "A state of calm, peace, and tranquility", category: .emotion),
        SuggestionItem(content: "Euphoria", secondaryContent: "An intense feeling of excitement and happiness", category: .emotion),
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
