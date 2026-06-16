import SwiftData
import SwiftUI

struct SettingsView: View {
    @State private var isShowingHowToPlay = false
    @State private var isShowingQuestionSettings = false
    @State private var isShowingWordSettings = false
    @State private var isShowingGameSettings = false

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SuggestionCardView {
                        SectionHeaderView(text: "SETTINGS", color: Color.theme.offWhite.opacity(0.65))

                        Text("Manage your suggestion library.")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)

                        Button("Questions Settings") {
                            isShowingQuestionSettings = true
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("questions_settings_button")

                        Button("Words Settings") {
                            isShowingWordSettings = true
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("words_settings_button")

                        Button("Games Settings") {
                            isShowingGameSettings = true
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("games_settings_button")
                    }

                    SuggestionCardView(backgroundColor: Color.theme.headerCardBackground) {
                        SectionHeaderView(text: "HOW TO PLAY")

                        Button("Open Guide") {
                            isShowingHowToPlay = true
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("how_to_play_button")
                    }
                }
                .padding(32)
            }
        }
        .sheet(isPresented: $isShowingHowToPlay) {
            HowToPlayView()
        }
        .sheet(isPresented: $isShowingQuestionSettings) {
            QuestionSettingsView()
        }
        .sheet(isPresented: $isShowingWordSettings) {
            WordSettingsView()
        }
        .sheet(isPresented: $isShowingGameSettings) {
            GameSettingsView()
        }
    }
}

#Preview {
    SettingsView()
}
