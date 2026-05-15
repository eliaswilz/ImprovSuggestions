import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]

    @State private var isShowingHowToPlay = false
    @State private var isShowingResetConfirmation = false

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("SETTINGS")
                            .font(.sectionLabel)
                            .tracking(1.5)
                            .foregroundStyle(Color.theme.offWhite.opacity(0.65))

                        Text("Customize and manage your suggestion library.")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                    VStack(alignment: .leading, spacing: 16) {
                        Text("HOW TO PLAY")
                            .font(.sectionLabel)
                            .tracking(1.5)
                            .foregroundStyle(Color.theme.accentSage)

                        Button("Open Guide") {
                            isShowingHowToPlay = true
                        }
                        .buttonStyle(.primaryPill)
                        .accessibilityIdentifier("how_to_play_button")
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme.headerCardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

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
            persistenceAlertManager.showSaveError(
                action: "Your app data could not be reset.",
                error: error
            )
        }
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
