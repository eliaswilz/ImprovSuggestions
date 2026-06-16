import SwiftData
import SwiftUI

struct QuestionModeView: View {
    @Environment(AppState.self) private var appState
    @Query private var suggestions: [SuggestionItem]
    
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

                    VStack(spacing: 16) {
                        Button("Next Question") {
                            HapticManager.impact(.light)
                            appState.showNextQuestion()
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("next_question_button")

                        Button("Simulate Audience Response") {
                            appState.toggleAudienceResponse()
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("simulate_audience_response_button")
                        .disabled(appState.currentQuestion?.secondaryContent == nil)
                        .opacity(appState.currentQuestion?.secondaryContent == nil ? 0.5 : 1)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }
        }
        .onAppear {
            appState.suggestions = suggestions
        }
        .onChange(of: suggestions) { _, newSuggestions in
            appState.suggestions = newSuggestions
        }
    }
}

#Preview {
    QuestionModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
