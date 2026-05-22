import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]

    @State private var isShowingHowToPlay = false
    @State private var isShowingResetConfirmation = false
    @State private var isShowingAddSuggestion = false

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SuggestionCardView {
                        SectionHeaderView(text: "SETTINGS", color: Color.theme.offWhite.opacity(0.65))

                        Text("Customize and manage your suggestion library.")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }

                    Button("Add Suggestion") {
                        isShowingAddSuggestion = true
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("add_suggestion_button")

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
        .sheet(isPresented: $isShowingAddSuggestion) {
            AddSuggestionView()
        }
        .confirmationDialog(
            "This will delete all custom suggestions and clear all favorites.",
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

private struct HowToPlayView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    modeDescription(
                        title: "Questions",
                        text: "Generate audience-style questions to inspire a scene premise or opening offer."
                    )

                    modeDescription(
                        title: "Words",
                        text: "Choose a category, then generate objects, locations, professions, or emotions for fast prompts."
                    )

                    modeDescription(
                        title: "Games",
                        text: "Use structured improv games like First Line, Last Line or Changing Emotions."
                    )

                    Spacer()
                }
                .padding(32)
            }
            .navigationTitle("How to Play")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func modeDescription(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.sectionLabel)
                .tracking(1.5)
                .foregroundStyle(Color.theme.accentSage)

            Text(text)
                .font(.body)
                .foregroundStyle(Color.theme.offWhite)
                .multilineTextAlignment(.leading)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    SettingsView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
