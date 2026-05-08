import SwiftData
import SwiftUI

struct QuestionModeView: View {
    @Query(filter: #Predicate<SuggestionItem> { suggestion in
        suggestion.category == "question"
    }) private var questions: [SuggestionItem]

    @State private var currentQuestion: SuggestionItem?
    @State private var isShowingAudienceResponse = false
    @State private var questionQueue: [SuggestionItem] = []

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 32) {
                ModeHeaderCard(
                    title: "Question Mode",
                    subtitle: "Tap to generate a new audience question"
                )

                VStack(alignment: .leading, spacing: 24) {
                    Text(currentQuestion?.content ?? "No questions available")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.65)

                    if isShowingAudienceResponse, let secondaryContent = currentQuestion?.secondaryContent {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("AUDIENCE RESPONSE")
                                .font(.sectionLabel)
                                .tracking(1.5)
                                .foregroundStyle(Color.theme.offWhite.opacity(0.55))

                            Text(secondaryContent)
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(Color.theme.offWhite)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding(32)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(Color.theme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                Spacer()

                VStack(spacing: 16) {
                    Button("Next Question") {
                        showRandomQuestion()
                    }
                    .buttonStyle(.primaryPill)

                    Button("Simulate Audience Response") {
                        isShowingAudienceResponse = true
                    }
                    .buttonStyle(.primaryPill)
                    .disabled(currentQuestion?.secondaryContent == nil)
                    .opacity(currentQuestion?.secondaryContent == nil ? 0.5 : 1)
                }
            }
            .padding(.vertical, 32)
        }
        .onAppear {
            if currentQuestion == nil {
                showRandomQuestion()
            }
        }
        .onChange(of: questions) { _, _ in
            if currentQuestion == nil {
                showRandomQuestion()
            }
        }
    }

    private func showRandomQuestion() {
        if questionQueue.isEmpty {
            questionQueue = questions.shuffled()
        }

        currentQuestion = questionQueue.popLast()
        isShowingAudienceResponse = false
    }
}

#Preview {
    QuestionModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
