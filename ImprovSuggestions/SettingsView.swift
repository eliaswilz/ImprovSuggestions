import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]

    @State private var isShowingHowToPlay = false
    @State private var isShowingResetConfirmation = false
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

                    Button("Reset App Data") {
                        isShowingResetConfirmation = true
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("reset_app_data_button")
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
        .confirmationDialog(
            "This will delete all custom suggestions.",
            isPresented: $isShowingResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reset App Data", role: .destructive) {
                resetAppData()
            }

            Button("Cancel", role: .cancel) { }
        }
    }

    private func resetAppData() {
        DataManager.shared.resetAppData(
            suggestions: suggestions,
            modelContext: modelContext,
            alertManager: persistenceAlertManager
        )
    }
}

#Preview {
    SettingsView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
