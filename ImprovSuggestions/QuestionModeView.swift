import SwiftData
import SwiftUI

struct QuestionModeView: View {
    @Query private var suggestions: [SuggestionItem]

    @State private var currentQuestion: SuggestionItem?
    @State private var isShowingAudienceResponse = false
    @State private var questionQueueManager = SuggestionQueueManager()

    private var questions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.question) }
    }

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
                        .accessibilityIdentifier("question_text")

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
                        HapticManager.impact(.light)
                        showRandomQuestion()
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("next_question_button")

                    Button("Simulate Audience Response") {
                        isShowingAudienceResponse = true
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("simulate_audience_response_button")
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
        currentQuestion = questionQueueManager.next(from: questions)
        isShowingAudienceResponse = false
    }
}

#Preview {
    QuestionModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
