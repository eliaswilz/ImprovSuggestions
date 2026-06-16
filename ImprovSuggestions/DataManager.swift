import Foundation
import SwiftData

@MainActor
final class DataManager {
    static let shared = DataManager()

    static let initialSuggestions: [SuggestionItem] = [
        // Questions
        SuggestionItem(id: UUID(uuidString: "6DD06448-22A8-47C9-9CC3-E9BC00E059AA")!, content: "What's a profession one of your grandparents had?", category: .question),
        SuggestionItem(id: UUID(uuidString: "5A7EAAD0-C38F-4296-A6BE-E4ECC676D139")!, content: "What's a profession you think will still exist in 1000 years?", category: .question),
        SuggestionItem(id: UUID(uuidString: "D89FA74E-3B75-4ABC-A0F9-496F800EC6CF")!, content: "What's a profession you wanted to be as a child when you grew up?", category: .question),
        SuggestionItem(id: UUID(uuidString: "75A5A839-DFF8-494E-A8A6-76FEA94CA624")!, content: "What does your most interesting friend do for work?", category: .question),
        SuggestionItem(id: UUID(uuidString: "1C365E45-0B67-4652-B55F-B6E002F0CF73")!, content: "What's an item that makes you nostalgic for summer?", category: .question),
        SuggestionItem(id: UUID(uuidString: "80DF8783-A86A-4421-A6C2-D1CF4A5CC191")!, content: "If you went to a secondhand store, what's an object you would be excited to find?", category: .question),
        SuggestionItem(id: UUID(uuidString: "658BD273-61A9-4826-8355-5003C1E7D1F3")!, content: "What's something you ordered on Amazon recently?", category: .question),
        SuggestionItem(id: UUID(uuidString: "B528C75C-AEE0-43E2-BA52-76B4903AB72B")!, content: "What's an object in the trunk of your car?", category: .question),
        SuggestionItem(id: UUID(uuidString: "BE9B0B8D-FE24-41CE-B4E0-9C45303CD4DD")!, content: "What's an object at home you should've thrown away by now?", category: .question),
        SuggestionItem(id: UUID(uuidString: "466990BD-C31F-46BE-8341-FA2C22338541")!, content: "What's a geographical feature?", category: .question),
        SuggestionItem(id: UUID(uuidString: "02839359-4359-49D7-B9A8-87C6975F1F3E")!, content: "If you were on vacation what's the type of place you would go?", category: .question),
        SuggestionItem(id: UUID(uuidString: "43E1A8EF-2126-4715-B3D9-6CDE2EE51383")!, content: "What's a location you would visit in a small town?", category: .question),
        SuggestionItem(id: UUID(uuidString: "A7FD7B04-D8ED-4495-803D-0E553E024C3C")!, content: "What's a non-geographic location?", category: .question),
        SuggestionItem(id: UUID(uuidString: "B4D9E332-B65A-4FC5-9F58-4F3257D76E77")!, content: "What's your favorite type of store?", category: .question),
        SuggestionItem(id: UUID(uuidString: "6C62CB36-65ED-4204-B82B-F9AF94C8F210")!, content: "What's a job you would never want but respect enormously?", category: .question),
        SuggestionItem(id: UUID(uuidString: "7C37F353-9F9B-4D1F-917C-8D5E71800862")!, content: "What's a profession you associate with your hometown?", category: .question),
        SuggestionItem(id: UUID(uuidString: "BA006ABB-157E-4DE0-BE8D-7CCE46D3CE08")!, content: "What's a job you think sounds made up but is completely real?", category: .question),
        SuggestionItem(id: UUID(uuidString: "939E08DA-2732-47EE-89E3-23C90AEF6840")!, content: "What's a profession you'd choose if you had to start over tomorrow?", category: .question),
        SuggestionItem(id: UUID(uuidString: "F796E6B6-FFCF-4E99-B57F-FA788EB83DCB")!, content: "What's a job title that exists at your workplace that confuses you?", category: .question),
        SuggestionItem(id: UUID(uuidString: "B178752E-1872-4654-8D33-212EE30E3530")!, content: "What's a profession your parents warned you against?", category: .question),
        SuggestionItem(id: UUID(uuidString: "A0D1829D-58D0-4146-981F-EB0746CAC040")!, content: "What's something currently on your nightstand?", category: .question),
        SuggestionItem(id: UUID(uuidString: "3C4E5FE2-AE36-4254-86E1-918BDC23E8E2")!, content: "What's an object you own that you've never actually used?", category: .question),
        SuggestionItem(id: UUID(uuidString: "07311089-9573-4B12-BF9B-C86AA3C702C0")!, content: "What's the oldest thing in your refrigerator right now?", category: .question),
        SuggestionItem(id: UUID(uuidString: "42327502-8FCC-476A-96C2-7F38C14FE71F")!, content: "What's something in your junk drawer you can't throw away?", category: .question),
        SuggestionItem(id: UUID(uuidString: "D15AB1E9-3B7D-45AD-80AF-1C5103FB0FB3")!, content: "What's an object you've moved with you to every home you've lived in?", category: .question),
        SuggestionItem(id: UUID(uuidString: "CD987D5C-DFD6-4324-89B9-84B902CCD89B")!, content: "What's something you bought at a gas station that wasn't food or gas?", category: .question),
        SuggestionItem(id: UUID(uuidString: "76973C91-5F80-459E-B5FC-024DFD59B45A")!, content: "What's a tool you own but have no idea how to use?", category: .question),
        SuggestionItem(id: UUID(uuidString: "AFCFA804-11A5-4D33-9AE3-EC837382D30D")!, content: "What's something you've borrowed from someone and never returned?", category: .question),
        SuggestionItem(id: UUID(uuidString: "23146E57-1C79-4896-B914-567557E5B57A")!, content: "What's an object you'd grab first in a fire after your family and pets?", category: .question),
        SuggestionItem(id: UUID(uuidString: "13966C57-0333-456F-B92C-299FD5569847")!, content: "What's something you've lost and replaced, then found again?", category: .question),
        SuggestionItem(id: UUID(uuidString: "46B3E1BF-C9EB-4BC7-95B6-6BB0FCE387FD")!, content: "What's an item you always forget to pack when traveling?", category: .question),
        SuggestionItem(id: UUID(uuidString: "87E3EA37-FE6B-4E76-A24D-D9FB07705740")!, content: "What's something in your bathroom cabinet you've had for over a year?", category: .question),
        SuggestionItem(id: UUID(uuidString: "3DB667E5-0E5D-4C83-9096-806D6ADA24B2")!, content: "What's a food you loved as a kid that you'd be embarrassed to admit you still eat?", category: .question),
        SuggestionItem(id: UUID(uuidString: "21421A6A-301F-4C3D-8E1D-90709F9DE34D")!, content: "What's a condiment you put on things you probably shouldn't?", category: .question),
        SuggestionItem(id: UUID(uuidString: "CCE21585-0923-456E-BEB5-054DB7C00DD0")!, content: "What's a snack you can't keep in the house because you'll finish it immediately?", category: .question),
        SuggestionItem(id: UUID(uuidString: "426E36EA-2B5C-4210-8B73-49E4B917D8CD")!, content: "What's a food you've never tried but feel like you should have by now?", category: .question),
        SuggestionItem(id: UUID(uuidString: "9353370F-8E99-4736-B4B3-D30BE21D72D5")!, content: "What's a drink you associate with a specific memory?", category: .question),
        SuggestionItem(id: UUID(uuidString: "4452D040-9B20-41C4-BAA5-A8269BE87790")!, content: "What's a food you pretend to like in social situations?", category: .question),
        SuggestionItem(id: UUID(uuidString: "7BE8AF0B-C0E6-486D-BBF1-395362FC3F9C")!, content: "What's a type of place you always end up at on a road trip?", category: .question),
        SuggestionItem(id: UUID(uuidString: "0F4FCA7A-5B1F-4B5C-8635-DFC09B630C10")!, content: "What's a room in your house you avoid?", category: .question),
        SuggestionItem(id: UUID(uuidString: "7B6FAEBF-E95F-4782-9653-BF72F9E6DA9B")!, content: "What's a place in your city you've driven past a hundred times but never been inside?", category: .question),
        SuggestionItem(id: UUID(uuidString: "706090EB-2D53-41CC-B57A-7FE2311AA2E7")!, content: "What's a type of place you'd find in every small town in America?", category: .question),
        SuggestionItem(id: UUID(uuidString: "55151E57-6D26-48B4-9AFF-9518F77CC2E6")!, content: "What's a place you went as a kid that felt magical but would probably disappoint you now?", category: .question),
        SuggestionItem(id: UUID(uuidString: "347CC52B-F727-4345-A44B-B44425505D31")!, content: "What's a location you'd pick for a first date?", category: .question),
        SuggestionItem(id: UUID(uuidString: "E546572A-D108-4D9A-B9DB-CA3CD3BB3030")!, content: "What's a type of weather that makes you irrationally happy?", category: .question),
        SuggestionItem(id: UUID(uuidString: "4805656C-FAEF-4FEC-8AC9-A4014BF76066")!, content: "What's an animal you'd be fine never encountering in the wild?", category: .question),
        SuggestionItem(id: UUID(uuidString: "8E508AA2-9055-4237-ACBB-119DFDED7F82")!, content: "What's a natural phenomenon you've always wanted to witness in person?", category: .question),
        SuggestionItem(id: UUID(uuidString: "D26EAD78-9019-4FC6-838D-3334C2FBA1A1")!, content: "What's a type of terrain that makes you feel at peace?", category: .question),
        SuggestionItem(id: UUID(uuidString: "3B61A5EA-489D-4F7D-A047-339B2F5BB3F2")!, content: "What's an insect you have an unreasonable fear of?", category: .question),
        SuggestionItem(id: UUID(uuidString: "C584099F-00B7-4D8C-A233-06CF5BEF4A9E")!, content: "What's a hobby you picked up during a difficult period in your life?", category: .question),
        SuggestionItem(id: UUID(uuidString: "13DED4D7-41C9-47A7-AE0B-762B73F84F9E")!, content: "What's something you do every morning without thinking about it?", category: .question),
        SuggestionItem(id: UUID(uuidString: "48397CB9-07DC-4DB3-B458-B5313961A309")!, content: "What's a genre of movie you'd never admit is your comfort watch?", category: .question),
        SuggestionItem(id: UUID(uuidString: "E92DBC47-F921-433E-BD4B-D0B5B9DB6CE1")!, content: "What's a sport you played as a kid that you were genuinely bad at?", category: .question),
        SuggestionItem(id: UUID(uuidString: "A7B384E8-9C30-4315-8E3B-BB94FA3B9391")!, content: "What's a hobby you've bought all the equipment for but barely practiced?", category: .question),
        SuggestionItem(id: UUID(uuidString: "A377F646-1954-41D5-8065-23CA17799863")!, content: "What's something you collect, even if you don't think of yourself as a collector?", category: .question),
        SuggestionItem(id: UUID(uuidString: "284C81DB-E724-4E54-8866-735DB6C8872E")!, content: "What's a skill you have that would surprise people who know you?", category: .question),
        SuggestionItem(id: UUID(uuidString: "17841044-6DE0-4ECF-995A-FDF900E09296")!, content: "What's a TV show you could quote from memory?", category: .question),
        SuggestionItem(id: UUID(uuidString: "4144A7EB-A39A-4B63-B6BB-CAF3A73854BD")!, content: "What's a toy you remember wanting desperately as a kid?", category: .question),
        SuggestionItem(id: UUID(uuidString: "5D0B0CBD-9742-4643-BAA9-B6BAB86B3DEC")!, content: "What's a trend from your teenage years you're glad is gone?", category: .question),
        SuggestionItem(id: UUID(uuidString: "6BBC3D20-555C-4195-BE69-0BBB80DC53BC")!, content: "What's a band or musician you were obsessed with at some point and now can't explain?", category: .question),
        SuggestionItem(id: UUID(uuidString: "BFD3493B-7B9F-4BCC-9654-0FF38487A9DE")!, content: "What's a holiday tradition from your family that you've never seen anywhere else?", category: .question),
        SuggestionItem(id: UUID(uuidString: "DC0F8335-0F69-42D3-B92A-B72D5A289517")!, content: "If you had to survive a week in the wilderness, what's one thing you'd bring?", category: .question),
        SuggestionItem(id: UUID(uuidString: "1DEED798-7D6F-4745-8965-863C96223D3C")!, content: "If you opened a small business tomorrow, what would it sell?", category: .question),
        SuggestionItem(id: UUID(uuidString: "0B932F51-C438-4DF2-90EC-5B95ACFDC6C8")!, content: "If you could only eat food from one country for the rest of your life, which country?", category: .question),

        // Objects
        SuggestionItem(id: UUID(uuidString: "1D80C3B5-97C0-43E8-9785-24ACD952F617")!, content: "a suspiciously heavy briefcase", category: .object),
        SuggestionItem(id: UUID(uuidString: "A3D2CFCD-715E-4B37-8748-01CBA102937F")!, content: "a singing toaster", category: .object),
        SuggestionItem(id: UUID(uuidString: "E8D7B7C5-4F7E-42B0-BAED-37AF2A43D7D9")!, content: "a family heirloom snow globe", category: .object),
        SuggestionItem(id: UUID(uuidString: "AE019CF9-285F-4B9D-AF6F-BF4DA732AC9B")!, content: "an umbrella that only opens indoors", category: .object),
        SuggestionItem(id: UUID(uuidString: "A021FC2B-9ACF-4998-AC8A-B1B642889FC9")!, content: "a cookbook written in invisible ink", category: .object),
        SuggestionItem(id: UUID(uuidString: "983905A5-4B5B-480B-8945-0B55FFB0EB10")!, content: "a trophy for worst customer service", category: .object),
        SuggestionItem(id: UUID(uuidString: "A5E5F4D0-70F2-49B9-A816-51345D921565")!, content: "a bouquet of plastic roses", category: .object),
        SuggestionItem(id: UUID(uuidString: "0D2BA6C2-F191-4FCB-A81E-3224ABFD3529")!, content: "a haunted GPS device", category: .object),
        SuggestionItem(id: UUID(uuidString: "3CA12579-9B0E-4014-903F-ABBB4C15F38F")!, content: "an abandoned amusement park", category: .location),
        SuggestionItem(id: UUID(uuidString: "E9D5C1CB-20BC-40F9-B2B7-885CE8A35AB0")!, content: "the break room of a luxury hotel", category: .location),
        SuggestionItem(id: UUID(uuidString: "6C19E1ED-2C9E-4725-B99A-77F1F61EC7C7")!, content: "a submarine gift shop", category: .location),
        SuggestionItem(id: UUID(uuidString: "076B1C4E-8036-4DDE-824C-FB0BF0FEFC47")!, content: "the waiting room outside a dragon's dentist", category: .location),
        SuggestionItem(id: UUID(uuidString: "52267C61-58C7-4553-B5A6-35D9F4FABDF7")!, content: "a rooftop garden during a thunderstorm", category: .location),
        SuggestionItem(id: UUID(uuidString: "877247AD-136F-4CDF-8F87-0D3D8EEE6BA3")!, content: "a tiny town's only escalator", category: .location),
        SuggestionItem(id: UUID(uuidString: "E382763D-AD6E-4512-B460-D7090DDE7857")!, content: "a museum of failed inventions", category: .location),
        SuggestionItem(id: UUID(uuidString: "0CC91BDB-8633-4208-826B-A55FC965AA4A")!, content: "the backstage area of a children's talent show", category: .location),
        SuggestionItem(id: UUID(uuidString: "B20CCD9B-BF51-4B34-A77B-43D36EF9DEE9")!, content: "wedding planner for monsters", category: .profession),
        SuggestionItem(id: UUID(uuidString: "AF8510C7-87D8-44CD-B635-4EBF9DBA4C4D")!, content: "professional apology writer", category: .profession),
        SuggestionItem(id: UUID(uuidString: "19E8E371-DE66-4FDA-8596-E60C2B79BF24")!, content: "undercover librarian", category: .profession),
        SuggestionItem(id: UUID(uuidString: "C58952F9-CBE6-44CA-9009-68A19AF9780D")!, content: "competitive dog groomer", category: .profession),
        SuggestionItem(id: UUID(uuidString: "69901F88-0CC4-476B-B698-2CAB03DAB83D")!, content: "fortune cookie editor", category: .profession),
        SuggestionItem(id: UUID(uuidString: "0A1430E5-B8DA-4982-8114-3291B223DB82")!, content: "volcano tour guide", category: .profession),
        SuggestionItem(id: UUID(uuidString: "E1ADF20E-4104-4378-9D30-22C50671789F")!, content: "alien etiquette coach", category: .profession),
        SuggestionItem(id: UUID(uuidString: "1A211E0E-F92E-4385-BAFD-7277FC817696")!, content: "retired superhero accountant", category: .profession),
        SuggestionItem(id: UUID(uuidString: "737A017F-35EA-4865-AFED-348DBCC4E8C7")!, content: "Overjoyed But Trying To Seem Professional", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "08F6E4D7-52B7-4A61-AE66-3EBC99883E95")!, content: "Quietly Jealous", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "CBD52064-7287-44A7-B7F7-89F6DAFD8AB6")!, content: "Unreasonably Confident", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "1B51F175-144E-4786-882D-DB77BB371D02")!, content: "Nostalgic For Something That Happened Yesterday", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "CC53C352-00FE-4BAC-9313-09BBAFAB1983")!, content: "Terrified Of Disappointing A Child", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "1E162AAB-4E79-405E-B5CD-BE98A0C8E9A5")!, content: "Deeply Offended By A Compliment", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "1E792423-1BB0-4661-BF5A-39C896DFFB8B")!, content: "Suspiciously Calm", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "D6AEA4FD-54E4-47D0-BC31-884E263051F5")!, content: "Furious But Whispering", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "49959382-2BBB-4205-849A-681610099A93")!, content: "Joy", secondaryContent: "A feeling of great pleasure and happiness", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "A347A7CA-93E1-4F08-BAE3-E654C636055F")!, content: "Sadness", secondaryContent: "A state of sorrow or unhappiness", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "05BF304A-53E5-4296-B753-5FC3025E6227")!, content: "Anger", secondaryContent: "A strong feeling of displeasure or hostility", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "8217AE60-1804-43CC-9C20-4C854DA993E8")!, content: "Fear", secondaryContent: "An unpleasant emotion caused by perceived danger or threat", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "3428CD43-13F2-4B0D-A43A-B9A78B452905")!, content: "Surprise", secondaryContent: "A feeling caused by something unexpected or sudden", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "2274D645-A060-4BC4-B87A-8914C1BE9AA6")!, content: "Disgust", secondaryContent: "A strong sense of revulsion or aversion", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "D4FA81A7-E347-4E8C-AAD8-4C7B6A75948A")!, content: "Anticipation", secondaryContent: "Excitement or anxiety about a future event", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "D09E66DD-49D5-470E-AB81-C705DFD81047")!, content: "Trust", secondaryContent: "A feeling of confidence and reliance in someone or something", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "2B93650C-6758-4339-8574-DBD0428A65D7")!, content: "Love", secondaryContent: "A deep affection and attachment toward someone", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "16AD18F7-051C-4956-BEF2-FDB19B3A5B22")!, content: "Guilt", secondaryContent: "A feeling of responsibility or remorse for a wrongdoing", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "91DEC160-2715-40F6-A4ED-649E56AF12F9")!, content: "Shame", secondaryContent: "A painful sense of humiliation or distress over one's actions", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "9C6E2777-D26B-4709-9B40-50615B3D15B2")!, content: "Pride", secondaryContent: "Satisfaction derived from one's own achievements or qualities", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "B8AE44C1-CFC9-484F-92D5-153182A368B6")!, content: "Envy", secondaryContent: "Resentment toward someone else's advantages or possessions", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "8D947E86-3232-4322-981D-873325D8C496")!, content: "Jealousy", secondaryContent: "Fear of losing something valued to a rival", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "D0212019-9BBF-40B2-BD08-7E217EB06488")!, content: "Gratitude", secondaryContent: "A warm feeling of thankfulness toward others", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "EC5F39DC-9665-467C-9302-45EB422A7FA9")!, content: "Awe", secondaryContent: "An overwhelming sense of wonder and reverence", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "EC78DF73-10A9-40A1-BACD-524D7F3EF174")!, content: "Contempt", secondaryContent: "A feeling of disdain or superiority over others", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "2F835B13-B9F0-45B3-88D3-7248A54157A0")!, content: "Loneliness", secondaryContent: "A sense of isolation and lack of connection", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "0FC52A9D-B644-4EB3-A621-89171967AC3A")!, content: "Boredom", secondaryContent: "A state of weariness from lack of interest or stimulation", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "3B845A30-3654-4AC9-9DD3-1C82E7D425AF")!, content: "Curiosity", secondaryContent: "A strong desire to know or learn something", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "45C38E26-C104-41BE-8B11-F8362410CF28")!, content: "Compassion", secondaryContent: "Sympathetic concern for the suffering of others", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "FB1BBED6-3405-4039-8D52-F3F03960DB2A")!, content: "Nostalgia", secondaryContent: "A sentimental longing for the past", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "7388A0B5-4085-4DF3-86C8-4AE845E485AB")!, content: "Anxiety", secondaryContent: "A feeling of worry, nervousness, or unease", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "5BE202C6-E287-4FAB-AF8F-FAF0EC70B722")!, content: "Serenity", secondaryContent: "A state of calm, peace, and tranquility", category: .emotion),
        SuggestionItem(id: UUID(uuidString: "CEC2980C-25CF-43A6-9FAC-DCE3FF90A8D5")!, content: "Euphoria", secondaryContent: "An intense feeling of excitement and happiness", category: .emotion),

        // Dialogue
        SuggestionItem(id: UUID(uuidString: "BFCEDEEF-8DF8-4ACB-8350-9ACA1FD226CD")!, content: "I told you not to press the red button.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "2FCD2943-63D7-4EE2-BC6A-C2EA4942A019")!, content: "It was glowing at me.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "B762C521-5D06-438B-912D-6969686EF7C4")!, content: "This is not how my grandmother described treasure hunting.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9AB3D8AD-48E9-439B-B64F-BD984AF27E63")!, content: "Your grandmother had a very selective memory.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8742263C-72F0-4BD3-8A2D-B2E888FDDFD5")!, content: "If anyone asks, we were never in the aquarium.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7B6485FC-E058-41D6-8509-34A1F1A04B54")!, content: "Then why am I holding a seahorse?", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8BE1677C-24AC-4AFE-B524-A99E65D6DF08")!, content: "The ceremony starts in five minutes and the rings are missing.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "E639D502-08D1-46B8-8ECB-7752882810FE")!, content: "Define missing.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DD68133F-C576-4B05-8D44-4F8760A88B92")!, content: "I finally translated the note from the future.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "83DD674F-B2BC-47B5-96E5-39D2F603B13C")!, content: "Does it mention lunch?", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "02A209E2-91F3-494E-80B0-AE3E16B77C53")!, content: "You promised the robot it could be best man.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "55176B17-3D32-486E-ACB7-B99CD6054944")!, content: "It caught the bouquet fair and square.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7B65EB99-EC57-448B-B6A7-432BF21B7D67")!, content: "I cannot believe you invited my nemesis to brunch.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "09CF6499-C555-428C-AFC9-756B1D40B353")!, content: "Technically, he RSVP'd as plus one.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F64F79EE-7121-4B50-9A0D-C628A2BC651A")!, content: "The ghost says we are using the wrong cheese.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "35B7EBB7-5BDB-4311-B2ED-06A5A9D11667")!, content: "The ghost has always been dramatic about fondue.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DDECEFD6-9470-46E7-9825-0619E694A15A")!, content: "That's the third time this week you've said that.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "996535E0-35E0-4824-97CB-062C25EF4DBF")!, content: "I'm not saying it was a mistake, I'm just saying it didn't work.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "1531DEE7-0F2A-4117-8F0B-E30F0250B86F")!, content: "Can you just pretend you didn't hear that part?", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "6DBB1447-4018-49EA-8EDD-31D83D73580F")!, content: "I thought you knew about the parking situation.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "5537CA6F-B8D0-456B-8755-52B884D5A8C2")!, content: "We've been standing here for twenty minutes.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "980FCD11-31B4-4C4D-889A-5461CEB1B309")!, content: "I don't actually know whose dog this is.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8131B02D-FC62-4A8D-A3AF-B9B9E8810C70")!, content: "That's a very confident guess for someone who wasn't there.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "4BA95E83-01F8-406F-8C2E-F80C20C532BA")!, content: "I told them the truth and somehow that made it worse.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "A50A75DC-BF65-4345-9D1B-BA471FF933F6")!, content: "I'm not lost, I just don't know where I am.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "0B9C6262-CE6F-407A-BB22-C126D1DE3914")!, content: "She said she'd be five minutes and that was an hour ago.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "6960A421-E80F-452E-8E55-C483E6A15D41")!, content: "I'm going to need you to lower your voice just a little.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "E6BE6016-CF79-43BB-831D-CE50782D16AD")!, content: "I didn't realize that was a formal event.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "5B9BFB71-B41B-469C-B7E8-16A96670C79A")!, content: "Okay but in my defense, I was really tired.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "4BAF5A0A-74B0-4D0D-A8DF-AF6E7C356224")!, content: "I've been avoiding that conversation for about six months.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7885A58A-F66F-4B01-B314-AB27FDE235D3")!, content: "You're going to want to sit down for this one.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7D5BAE2C-C025-496E-B817-5EAD40656833")!, content: "I thought it was implied that I was coming.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F5C7F5C0-EE3C-42F6-8BD4-E15AB1CA79D7")!, content: "That's not what I said, that's what you heard.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "41DFAAAE-29B4-4F3A-97DA-870B169F9A8F")!, content: "I'm not upset, I'm just processing.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "542CE4BF-3F5B-44E2-A81A-299ED2DE6B56")!, content: "I genuinely cannot remember if I locked the door.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "20804CB0-7DBE-4F3E-A4DB-65F4F026A48E")!, content: "We don't have to make it weird but it is a little weird.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "80F60016-70C6-446F-9E5D-E82DA5BCD1DF")!, content: "I paid for the last one, I'm pretty sure.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "265F333E-9BF8-4E33-BA28-CE36E274B57F")!, content: "You could've texted me that instead of calling.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "06184ECA-49E6-4A07-B9F9-6FA64E4C6660")!, content: "I'm not going to apologize for being efficient.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DCEF06B9-96C9-46A5-A81F-1B65EF87BAED")!, content: "That's a lot of steps for something that simple.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "037DB579-7595-49E9-9A90-F9107E91DC0E")!, content: "I didn't think anyone was still using that entrance.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F04371DF-6F5F-4CC5-B175-196D94CEA171")!, content: "I'm not saying it's your fault, I'm just saying you were there.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "441C16A3-3E63-4A47-AC42-5F1EB14A9FB2")!, content: "Honestly I thought that meeting was optional.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F87CA739-3A60-4083-8502-D841282A5CF1")!, content: "I've been mispronouncing that for years apparently.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9017007F-A6DE-4065-8B0B-1B64C17C0124")!, content: "You look exactly the same, that's insane.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "22FD487C-C8D1-4AD7-9798-B991F57291A3")!, content: "I didn't bring cash, I never bring cash anymore.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9525C72E-79E9-4DB9-88C1-52DFF2D01460")!, content: "That's the version of the story I'm going with.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "BA7D5108-5C39-414C-A2DB-D11FA348DDEC")!, content: "I'm going to need a minute before I respond to that.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9EBFE34E-C2D8-4B6D-83A8-44CDEA8B1A15")!, content: "I didn't know we were doing gifts this year.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "0AFBC396-EB92-4467-ABD9-89930E8787DF")!, content: "I've driven past that place a hundred times and never been inside.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DFB27E2D-5A44-46D4-8FFF-8761460E84DA")!, content: "You're allowed to just say no, you know.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F63CF99F-7F78-4988-A947-6B9DB8AD903F")!, content: "I thought we agreed not to bring that up at dinner.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "D16B8046-F8D0-47D8-ACF3-25181F0E5963")!, content: "I have strong feelings about this that I will share later.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "357B114F-1C78-42BD-AD9F-11EDD16AE7A3")!, content: "That's technically true but really misleading.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "D98617B8-DFFD-4E37-9E2C-01438BEBCF36")!, content: "I don't remember inviting that many people.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "CBED5CE9-1F7F-4EC3-A5A4-EC6110A1177F")!, content: "I'm not avoiding it, I'm just deprioritizing it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8092B8D0-22C9-4171-A6EF-B5213B3FE71E")!, content: "That's the second time today someone's said that to me.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7FE4B79E-843A-4DB6-99C7-8E2C97917D4C")!, content: "I thought you were joking until you weren't.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "90E2E0A5-CD08-432D-9B7B-A915AB50033A")!, content: "I'm going to pretend I understood that and move on.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "C0CFC643-E221-4FEF-A25B-127837A5019E")!, content: "We can talk about it but I already know how it ends.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9B80D183-8413-4A7B-AFD7-DA6D38C84DF0")!, content: "I didn't think it would take this long to explain.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8842F8FF-1688-41DF-9984-762D49CBAF89")!, content: "That's a completely different thing and you know it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "BC960FD9-30B0-4997-AC7D-C6798E7010CD")!, content: "I've been meaning to return that for about a year.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "28300ACA-351F-4A35-BB23-64206EF14574")!, content: "I'm not overthinking it, I'm just thinking about it a lot.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "FDD588A9-3538-46D9-A115-925AF422A4D1")!, content: "Next time just tell me and I'll act surprised.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "7E4E96CD-1FE0-4D4C-B035-72F10BE1C4D2")!, content: "You're still in the group chat though, right?", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "28B0DE42-D7A0-45AC-A1CF-81F5B49CC896")!, content: "I didn't say it was a good plan, I said it was a plan.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F4DB0337-9784-40DF-B7F8-5C479988A0DC")!, content: "We just kind of assumed someone else was handling that part.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "62A587AB-43FB-48CE-B755-D4578EEA7092")!, content: "There might be a version of this that works, I just haven't found it yet.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "FCE67311-F545-45C2-B801-8ACA8126C54B")!, content: "I know it looks bad but the context is actually really funny.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "6ACDA261-9608-4DBA-9D0D-C67ED3A539FF")!, content: "We've been doing it wrong this whole time and it was still kind of working.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "744A65E9-0752-4299-B360-94DFE0B78C4D")!, content: "I'm not saying I was right, I'm saying I wasn't entirely wrong.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "104B3703-A176-45B4-9C87-FF0920E858C3")!, content: "Someone changed the wifi password and didn't tell anyone.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "405883F2-C6FC-4564-ACF5-A6A5CDCE5650")!, content: "I thought the whole point was that nobody was supposed to know.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "5461D126-8655-4A26-B830-16F3B2D4166E")!, content: "We kind of just left it there and hoped nobody would notice.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "E3DAF832-8C1C-4754-8082-E2132D1588E1")!, content: "You can't keep using that as your excuse, it was two years ago.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "CF415CB5-D665-493B-AFA8-89F3D0CD7234")!, content: "I didn't read the whole thing, I read most of it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "0BDF26F8-BA61-4A11-84B1-D8C63D1ED425")!, content: "There's a version of events where I come out looking fine.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9446E48E-6ADC-4909-8877-C5BE0E77DE28")!, content: "We had a system and then someone improved it and now nothing works.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DC79F4B1-F72B-4A91-A328-7C95A09326A0")!, content: "I'm not in trouble, I'm just in a situation.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "A6DD5ED6-F654-45A1-A513-F0D59A1B065F")!, content: "You were the one who said it was load-bearing.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "E44D9B10-218A-4ADF-A101-FFE3670F9F4A")!, content: "I genuinely thought that was a decorative door.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9EDCFCBA-EFE7-4154-A200-1A86733671C1")!, content: "We stopped keeping score but I still know the score.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "4EB5110E-C674-4BDF-8110-5A71A8B04517")!, content: "I'm not saying you broke it, I'm saying it broke while you were using it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "709AE6E3-C277-4FFC-8767-5B68B7F21162")!, content: "That's the third workaround we've added to the first workaround.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "F4F6A3F5-91E5-4225-817C-2EE2293B46DA")!, content: "I only said it because I thought the mic was off.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "6ABA753C-37E3-4D4C-A216-872B0F4FA575")!, content: "We were going to label everything and then we just... didn't.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "CA9EC6DA-DC52-4CAA-B3F7-1BC6135B4DEE")!, content: "I think at some point we have to admit this is just how it is now.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9BDFF4F3-1A7A-466A-883B-8B8CF98D05E6")!, content: "You're not supposed to be able to get in that way.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "E85D6E34-FF0B-41B4-8132-E45D186F63BA")!, content: "I didn't delete it, I just moved it somewhere I can't find.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "C0F8A0CD-4F24-418D-8F91-4057056682C4")!, content: "We told everyone seven and we meant eight, they know that.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9BA94EA3-2095-4608-97F2-7E18B805F812")!, content: "I'm not ignoring the problem, I'm giving it space.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "96C7DCF3-489F-4BFD-A69A-BEC7B8C02FC0")!, content: "That's not graffiti, that's been there since we moved in.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "DBB89A4C-510F-42A2-8C40-B555727E55AF")!, content: "I thought you were the one with the key.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "931C3D9A-AC01-4500-8641-7CDC1765BFDE")!, content: "We didn't plan for it to turn into a whole thing.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "04C8DFE6-1BA5-4F6F-BBB8-A2FB81E73414")!, content: "I'm not defending it, I'm just explaining the logic at the time.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "C29F4163-81AE-4B4D-A9B8-3A7FA3D8F6F2")!, content: "Someone in this building has been stealing my exact yogurt.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "58484F36-A38D-4421-981C-86D02036C692")!, content: "I know it's not ideal but it does technically function.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "B5DF229B-C51A-4FE1-A8F9-64038366006B")!, content: "We shook on it, that should still count for something.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "C578644B-2FAB-464A-97CA-341862ACF99D")!, content: "I didn't know that was the last one or I would've been more careful with it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "A268BE0A-CD4C-41CE-A918-E2695A588185")!, content: "You can't just rename the folder and call it organized.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "BC447CFC-7B90-495E-9FE3-96D4A1534550")!, content: "I'm not angry, I'm just very specifically disappointed.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "878C090E-19D4-4A05-A04B-7A0008DE7871")!, content: "We put a note on it and the note is also gone now.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "0F995E89-8371-4BC5-84E4-F361073651A3")!, content: "That's not a shortcut, that's just a different kind of long way.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "31175AD7-A258-4EEB-852C-176981DBC8CC")!, content: "I thought the silence meant yes.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "A42F1716-8BF2-4698-B284-D21A8360AF0D")!, content: "We've been calling it the wrong thing for so long it's basically the right thing now.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9E011744-C9A4-4105-89C2-3ADE7C1CE31A")!, content: "I'm not avoiding you, I've just been in this exact spot all week.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "269DCD79-D83F-4ADA-8765-C5503C8D9400")!, content: "You said casual, I dressed casual, now apparently this is a problem.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "8C4833E6-B6A4-4A95-BAE3-93A1E58823FA")!, content: "I didn't think anyone was still using that account.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "D625ECCE-2008-4647-972B-BA4380D412E9")!, content: "We fixed the main issue but in doing so created a slightly different issue.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "878099DE-C908-44D2-B620-EF393A5274DC")!, content: "I'm not gonna lie, I thought that was going to go worse.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "9ABB04C6-F679-4C44-9522-9060A4D6AB8E")!, content: "Someone signed us up for something and I think it was me.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "AE0AEB8D-C03E-43B2-AC11-8991CA027773")!, content: "I didn't realize that was a rule until after I broke it.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "99D7D673-5F90-458F-B2A7-C58F72ABACFF")!, content: "We're not lost, we're just not where we thought we were.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "3F622A79-24AA-4997-8839-1C0AC937815A")!, content: "I thought you were being sarcastic so I was sarcastic back and now here we are.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "D489D846-42D8-4239-9F4E-435885C0AF98")!, content: "I already ate but I'll probably eat again.", category: .dialogue),
        SuggestionItem(id: UUID(uuidString: "3DA89D8B-0BDD-4DD2-A236-3D9434E12CB1")!, content: "Give me a place where two people should never break up.", secondaryContent: "Inside a revolving door.", category: .location)
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
