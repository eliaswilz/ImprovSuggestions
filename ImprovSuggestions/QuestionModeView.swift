import SwiftData
import SwiftUI

struct QuestionModeView: View {
    @Query private var suggestions: [SuggestionItem]
    
    @State private var viewModel = QuestionModeViewModel()

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                SuggestionCardView(spacing: 24) {
                    Text(viewModel.currentQuestion?.content ?? "No questions available")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("question_text")

                    if viewModel.isShowingAudienceResponse, let secondaryContent = viewModel.currentQuestion?.secondaryContent {
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
                            viewModel.showNextQuestion()
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("next_question_button")

                        Button("Simulate Audience Response") {
                            viewModel.toggleAudienceResponse()
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("simulate_audience_response_button")
                        .disabled(viewModel.currentQuestion?.secondaryContent == nil)
                        .opacity(viewModel.currentQuestion?.secondaryContent == nil ? 0.5 : 1)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }
        }
        .onAppear {
            viewModel.updateSuggestions(suggestions)
        }
        .onChange(of: suggestions) { _, newSuggestions in
            viewModel.updateSuggestions(newSuggestions)
        }
    }
}

#Preview {
    QuestionModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
