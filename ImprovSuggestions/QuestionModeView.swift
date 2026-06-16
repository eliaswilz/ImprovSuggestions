import SwiftUI

struct QuestionModeView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                SuggestionCardView(spacing: 24) {
                    Text(appState.currentQuestion?.content ?? "No questions available")
                        .font(.readableTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("question_text")

                    if appState.isShowingAudienceResponse, let secondaryContent = appState.currentQuestion?.secondaryContent {
                        VStack(alignment: .leading, spacing: 8) {
                            SectionHeaderView(text: "AUDIENCE RESPONSE")

                            Text(secondaryContent)
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(Color.theme.offWhite)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }

            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Button("Simulate Audience Response") {
                        appState.toggleAudienceResponse()
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("simulate_audience_response_button")
                    .disabled(appState.currentQuestion?.secondaryContent == nil)
                    .opacity(appState.currentQuestion?.secondaryContent == nil ? 0.5 : 1)

                    Button("Next Question") {
                        HapticManager.impact(.light)
                        appState.showNextQuestion()
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("next_question_button")
                }
                .padding(32)
            }
        }
    }
}

#Preview {
    QuestionModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
