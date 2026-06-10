import Foundation
import SwiftData

@MainActor
final class DataManager {
    static let shared = DataManager()

    static let initialSuggestions: [SuggestionItem] = [
        // Questions
        SuggestionItem(content: "What's a profession one of your grandparents had?", category: .question),
        SuggestionItem(content: "What's a profession you think will still exist in 1000 years?", category: .question),
        SuggestionItem(content: "What's a profession you wanted to be as a child when you grew up?", category: .question),
        SuggestionItem(content: "What does your most interesting friend do for work?", category: .question),
        SuggestionItem(content: "What's an item that makes you nostalgic for summer?", category: .question),
        SuggestionItem(content: "If you went to a secondhand store, what's an object you would be excited to find?", category: .question),
        SuggestionItem(content: "What's something you ordered on Amazon recently?", category: .question),
        SuggestionItem(content: "What's an object in the trunk of your car?", category: .question),
        SuggestionItem(content: "What's an object at home you should've thrown away by now?", category: .question),
        SuggestionItem(content: "What's a geographical feature?", category: .question),
        SuggestionItem(content: "If you were on vacation what's the type of place you would go?", category: .question),
        SuggestionItem(content: "What's a location you would visit in a small town?", category: .question),
        SuggestionItem(content: "What's a non-geographic location?", category: .question),
        SuggestionItem(content: "What's your favorite type of store?", category: .question),
        SuggestionItem(content: "What's a job you would never want but respect enormously?", category: .question),
        SuggestionItem(content: "What's a profession you associate with your hometown?", category: .question),
        SuggestionItem(content: "What's a job you think sounds made up but is completely real?", category: .question),
        SuggestionItem(content: "What's a profession you'd choose if you had to start over tomorrow?", category: .question),
        SuggestionItem(content: "What's a job title that exists at your workplace that confuses you?", category: .question),
        SuggestionItem(content: "What's a profession your parents warned you against?", category: .question),
        SuggestionItem(content: "What's something currently on your nightstand?", category: .question),
        SuggestionItem(content: "What's an object you own that you've never actually used?", category: .question),
        SuggestionItem(content: "What's the oldest thing in your refrigerator right now?", category: .question),
        SuggestionItem(content: "What's something in your junk drawer you can't throw away?", category: .question),
        SuggestionItem(content: "What's an object you've moved with you to every home you've lived in?", category: .question),
        SuggestionItem(content: "What's something you bought at a gas station that wasn't food or gas?", category: .question),
        SuggestionItem(content: "What's a tool you own but have no idea how to use?", category: .question),
        SuggestionItem(content: "What's something you've borrowed from someone and never returned?", category: .question),
        SuggestionItem(content: "What's an object you'd grab first in a fire after your family and pets?", category: .question),
        SuggestionItem(content: "What's something you've lost and replaced, then found again?", category: .question),
        SuggestionItem(content: "What's an item you always forget to pack when traveling?", category: .question),
        SuggestionItem(content: "What's something in your bathroom cabinet you've had for over a year?", category: .question),
        SuggestionItem(content: "What's a food you loved as a kid that you'd be embarrassed to admit you still eat?", category: .question),
        SuggestionItem(content: "What's a condiment you put on things you probably shouldn't?", category: .question),
        SuggestionItem(content: "What's a snack you can't keep in the house because you'll finish it immediately?", category: .question),
        SuggestionItem(content: "What's a food you've never tried but feel like you should have by now?", category: .question),
        SuggestionItem(content: "What's a drink you associate with a specific memory?", category: .question),
        SuggestionItem(content: "What's a food you pretend to like in social situations?", category: .question),
        SuggestionItem(content: "What's a type of place you always end up at on a road trip?", category: .question),
        SuggestionItem(content: "What's a room in your house you avoid?", category: .question),
        SuggestionItem(content: "What's a place in your city you've driven past a hundred times but never been inside?", category: .question),
        SuggestionItem(content: "What's a type of place you'd find in every small town in America?", category: .question),
        SuggestionItem(content: "What's a place you went as a kid that felt magical but would probably disappoint you now?", category: .question),
        SuggestionItem(content: "What's a location you'd pick for a first date?", category: .question),
        SuggestionItem(content: "What's a type of weather that makes you irrationally happy?", category: .question),
        SuggestionItem(content: "What's an animal you'd be fine never encountering in the wild?", category: .question),
        SuggestionItem(content: "What's a natural phenomenon you've always wanted to witness in person?", category: .question),
        SuggestionItem(content: "What's a type of terrain that makes you feel at peace?", category: .question),
        SuggestionItem(content: "What's an insect you have an unreasonable fear of?", category: .question),
        SuggestionItem(content: "What's a hobby you picked up during a difficult period in your life?", category: .question),
        SuggestionItem(content: "What's something you do every morning without thinking about it?", category: .question),
        SuggestionItem(content: "What's a genre of movie you'd never admit is your comfort watch?", category: .question),
        SuggestionItem(content: "What's a sport you played as a kid that you were genuinely bad at?", category: .question),
        SuggestionItem(content: "What's a hobby you've bought all the equipment for but barely practiced?", category: .question),
        SuggestionItem(content: "What's something you collect, even if you don't think of yourself as a collector?", category: .question),
        SuggestionItem(content: "What's a skill you have that would surprise people who know you?", category: .question),
        SuggestionItem(content: "What's a TV show you could quote from memory?", category: .question),
        SuggestionItem(content: "What's a toy you remember wanting desperately as a kid?", category: .question),
        SuggestionItem(content: "What's a trend from your teenage years you're glad is gone?", category: .question),
        SuggestionItem(content: "What's a band or musician you were obsessed with at some point and now can't explain?", category: .question),
        SuggestionItem(content: "What's a holiday tradition from your family that you've never seen anywhere else?", category: .question),
        SuggestionItem(content: "If you had to survive a week in the wilderness, what's one thing you'd bring?", category: .question),
        SuggestionItem(content: "If you opened a small business tomorrow, what would it sell?", category: .question),
        SuggestionItem(content: "If you could only eat food from one country for the rest of your life, which country?", category: .question),

        // Objects
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
        SuggestionItem(content: "Overjoyed But Trying To Seem Professional", category: .emotion),
        SuggestionItem(content: "Quietly Jealous", category: .emotion),
        SuggestionItem(content: "Unreasonably Confident", category: .emotion),
        SuggestionItem(content: "Nostalgic For Something That Happened Yesterday", category: .emotion),
        SuggestionItem(content: "Terrified Of Disappointing A Child", category: .emotion),
        SuggestionItem(content: "Deeply Offended By A Compliment", category: .emotion),
        SuggestionItem(content: "Suspiciously Calm", category: .emotion),
        SuggestionItem(content: "Furious But Whispering", category: .emotion),
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

        // Dialogue
        SuggestionItem(content: "I told you not to press the red button.", category: .dialogue),
        SuggestionItem(content: "It was glowing at me.", category: .dialogue),
        SuggestionItem(content: "This is not how my grandmother described treasure hunting.", category: .dialogue),
        SuggestionItem(content: "Your grandmother had a very selective memory.", category: .dialogue),
        SuggestionItem(content: "If anyone asks, we were never in the aquarium.", category: .dialogue),
        SuggestionItem(content: "Then why am I holding a seahorse?", category: .dialogue),
        SuggestionItem(content: "The ceremony starts in five minutes and the rings are missing.", category: .dialogue),
        SuggestionItem(content: "Define missing.", category: .dialogue),
        SuggestionItem(content: "I finally translated the note from the future.", category: .dialogue),
        SuggestionItem(content: "Does it mention lunch?", category: .dialogue),
        SuggestionItem(content: "You promised the robot it could be best man.", category: .dialogue),
        SuggestionItem(content: "It caught the bouquet fair and square.", category: .dialogue),
        SuggestionItem(content: "I cannot believe you invited my nemesis to brunch.", category: .dialogue),
        SuggestionItem(content: "Technically, he RSVP'd as plus one.", category: .dialogue),
        SuggestionItem(content: "The ghost says we are using the wrong cheese.", category: .dialogue),
        SuggestionItem(content: "The ghost has always been dramatic about fondue.", category: .dialogue),
        SuggestionItem(content: "That's the third time this week you've said that.", category: .dialogue),
        SuggestionItem(content: "I'm not saying it was a mistake, I'm just saying it didn't work.", category: .dialogue),
        SuggestionItem(content: "Can you just pretend you didn't hear that part?", category: .dialogue),
        SuggestionItem(content: "I thought you knew about the parking situation.", category: .dialogue),
        SuggestionItem(content: "We've been standing here for twenty minutes.", category: .dialogue),
        SuggestionItem(content: "I don't actually know whose dog this is.", category: .dialogue),
        SuggestionItem(content: "That's a very confident guess for someone who wasn't there.", category: .dialogue),
        SuggestionItem(content: "I told them the truth and somehow that made it worse.", category: .dialogue),
        SuggestionItem(content: "I'm not lost, I just don't know where I am.", category: .dialogue),
        SuggestionItem(content: "She said she'd be five minutes and that was an hour ago.", category: .dialogue),
        SuggestionItem(content: "I'm going to need you to lower your voice just a little.", category: .dialogue),
        SuggestionItem(content: "I didn't realize that was a formal event.", category: .dialogue),
        SuggestionItem(content: "Okay but in my defense, I was really tired.", category: .dialogue),
        SuggestionItem(content: "I've been avoiding that conversation for about six months.", category: .dialogue),
        SuggestionItem(content: "You're going to want to sit down for this one.", category: .dialogue),
        SuggestionItem(content: "I thought it was implied that I was coming.", category: .dialogue),
        SuggestionItem(content: "That's not what I said, that's what you heard.", category: .dialogue),
        SuggestionItem(content: "I'm not upset, I'm just processing.", category: .dialogue),
        SuggestionItem(content: "I genuinely cannot remember if I locked the door.", category: .dialogue),
        SuggestionItem(content: "We don't have to make it weird but it is a little weird.", category: .dialogue),
        SuggestionItem(content: "I paid for the last one, I'm pretty sure.", category: .dialogue),
        SuggestionItem(content: "You could've texted me that instead of calling.", category: .dialogue),
        SuggestionItem(content: "I'm not going to apologize for being efficient.", category: .dialogue),
        SuggestionItem(content: "That's a lot of steps for something that simple.", category: .dialogue),
        SuggestionItem(content: "I didn't think anyone was still using that entrance.", category: .dialogue),
        SuggestionItem(content: "I'm not saying it's your fault, I'm just saying you were there.", category: .dialogue),
        SuggestionItem(content: "Honestly I thought that meeting was optional.", category: .dialogue),
        SuggestionItem(content: "I've been mispronouncing that for years apparently.", category: .dialogue),
        SuggestionItem(content: "You look exactly the same, that's insane.", category: .dialogue),
        SuggestionItem(content: "I didn't bring cash, I never bring cash anymore.", category: .dialogue),
        SuggestionItem(content: "That's the version of the story I'm going with.", category: .dialogue),
        SuggestionItem(content: "I'm going to need a minute before I respond to that.", category: .dialogue),
        SuggestionItem(content: "I didn't know we were doing gifts this year.", category: .dialogue),
        SuggestionItem(content: "I've driven past that place a hundred times and never been inside.", category: .dialogue),
        SuggestionItem(content: "You're allowed to just say no, you know.", category: .dialogue),
        SuggestionItem(content: "I thought we agreed not to bring that up at dinner.", category: .dialogue),
        SuggestionItem(content: "I have strong feelings about this that I will share later.", category: .dialogue),
        SuggestionItem(content: "That's technically true but really misleading.", category: .dialogue),
        SuggestionItem(content: "I don't remember inviting that many people.", category: .dialogue),
        SuggestionItem(content: "I'm not avoiding it, I'm just deprioritizing it.", category: .dialogue),
        SuggestionItem(content: "That's the second time today someone's said that to me.", category: .dialogue),
        SuggestionItem(content: "I thought you were joking until you weren't.", category: .dialogue),
        SuggestionItem(content: "I'm going to pretend I understood that and move on.", category: .dialogue),
        SuggestionItem(content: "We can talk about it but I already know how it ends.", category: .dialogue),
        SuggestionItem(content: "I didn't think it would take this long to explain.", category: .dialogue),
        SuggestionItem(content: "That's a completely different thing and you know it.", category: .dialogue),
        SuggestionItem(content: "I've been meaning to return that for about a year.", category: .dialogue),
        SuggestionItem(content: "I'm not overthinking it, I'm just thinking about it a lot.", category: .dialogue),
        SuggestionItem(content: "Next time just tell me and I'll act surprised.", category: .dialogue),
        SuggestionItem(content: "You're still in the group chat though, right?", category: .dialogue),
        SuggestionItem(content: "I didn't say it was a good plan, I said it was a plan.", category: .dialogue),
        SuggestionItem(content: "We just kind of assumed someone else was handling that part.", category: .dialogue),
        SuggestionItem(content: "There might be a version of this that works, I just haven't found it yet.", category: .dialogue),
        SuggestionItem(content: "I know it looks bad but the context is actually really funny.", category: .dialogue),
        SuggestionItem(content: "We've been doing it wrong this whole time and it was still kind of working.", category: .dialogue),
        SuggestionItem(content: "I'm not saying I was right, I'm saying I wasn't entirely wrong.", category: .dialogue),
        SuggestionItem(content: "Someone changed the wifi password and didn't tell anyone.", category: .dialogue),
        SuggestionItem(content: "I thought the whole point was that nobody was supposed to know.", category: .dialogue),
        SuggestionItem(content: "We kind of just left it there and hoped nobody would notice.", category: .dialogue),
        SuggestionItem(content: "You can't keep using that as your excuse, it was two years ago.", category: .dialogue),
        SuggestionItem(content: "I didn't read the whole thing, I read most of it.", category: .dialogue),
        SuggestionItem(content: "There's a version of events where I come out looking fine.", category: .dialogue),
        SuggestionItem(content: "We had a system and then someone improved it and now nothing works.", category: .dialogue),
        SuggestionItem(content: "I'm not in trouble, I'm just in a situation.", category: .dialogue),
        SuggestionItem(content: "You were the one who said it was load-bearing.", category: .dialogue),
        SuggestionItem(content: "I genuinely thought that was a decorative door.", category: .dialogue),
        SuggestionItem(content: "We stopped keeping score but I still know the score.", category: .dialogue),
        SuggestionItem(content: "I'm not saying you broke it, I'm saying it broke while you were using it.", category: .dialogue),
        SuggestionItem(content: "That's the third workaround we've added to the first workaround.", category: .dialogue),
        SuggestionItem(content: "I only said it because I thought the mic was off.", category: .dialogue),
        SuggestionItem(content: "We were going to label everything and then we just... didn't.", category: .dialogue),
        SuggestionItem(content: "I think at some point we have to admit this is just how it is now.", category: .dialogue),
        SuggestionItem(content: "You're not supposed to be able to get in that way.", category: .dialogue),
        SuggestionItem(content: "I didn't delete it, I just moved it somewhere I can't find.", category: .dialogue),
        SuggestionItem(content: "We told everyone seven and we meant eight, they know that.", category: .dialogue),
        SuggestionItem(content: "I'm not ignoring the problem, I'm giving it space.", category: .dialogue),
        SuggestionItem(content: "That's not graffiti, that's been there since we moved in.", category: .dialogue),
        SuggestionItem(content: "I thought you were the one with the key.", category: .dialogue),
        SuggestionItem(content: "We didn't plan for it to turn into a whole thing.", category: .dialogue),
        SuggestionItem(content: "I'm not defending it, I'm just explaining the logic at the time.", category: .dialogue),
        SuggestionItem(content: "Someone in this building has been stealing my exact yogurt.", category: .dialogue),
        SuggestionItem(content: "I know it's not ideal but it does technically function.", category: .dialogue),
        SuggestionItem(content: "We shook on it, that should still count for something.", category: .dialogue),
        SuggestionItem(content: "I didn't know that was the last one or I would've been more careful with it.", category: .dialogue),
        SuggestionItem(content: "You can't just rename the folder and call it organized.", category: .dialogue),
        SuggestionItem(content: "I'm not angry, I'm just very specifically disappointed.", category: .dialogue),
        SuggestionItem(content: "We put a note on it and the note is also gone now.", category: .dialogue),
        SuggestionItem(content: "That's not a shortcut, that's just a different kind of long way.", category: .dialogue),
        SuggestionItem(content: "I thought the silence meant yes.", category: .dialogue),
        SuggestionItem(content: "We've been calling it the wrong thing for so long it's basically the right thing now.", category: .dialogue),
        SuggestionItem(content: "I'm not avoiding you, I've just been in this exact spot all week.", category: .dialogue),
        SuggestionItem(content: "You said casual, I dressed casual, now apparently this is a problem.", category: .dialogue),
        SuggestionItem(content: "I didn't think anyone was still using that account.", category: .dialogue),
        SuggestionItem(content: "We fixed the main issue but in doing so created a slightly different issue.", category: .dialogue),
        SuggestionItem(content: "I'm not gonna lie, I thought that was going to go worse.", category: .dialogue),
        SuggestionItem(content: "Someone signed us up for something and I think it was me.", category: .dialogue),
        SuggestionItem(content: "I didn't realize that was a rule until after I broke it.", category: .dialogue),
        SuggestionItem(content: "We're not lost, we're just not where we thought we were.", category: .dialogue),
        SuggestionItem(content: "I thought you were being sarcastic so I was sarcastic back and now here we are.", category: .dialogue),
        SuggestionItem(content: "I already ate but I'll probably eat again.", category: .dialogue),
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

    func toggleFavorite(suggestion: SuggestionItem, modelContext: ModelContext, alertManager: PersistenceAlertManager) {
        suggestion.isFavorite.toggle()
        
        do {
            try modelContext.save()
        } catch {
            suggestion.isFavorite.toggle()
            alertManager.showSaveError(
                action: "Your favorite change could not be saved.",
                error: error
            )
        }
    }

    func resetAppData(suggestions: [SuggestionItem], modelContext: ModelContext, alertManager: PersistenceAlertManager) {
        for suggestion in suggestions {
            if suggestion.isCustom {
                modelContext.delete(suggestion)
            } else if suggestion.isFavorite {
                suggestion.isFavorite = false
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
}
