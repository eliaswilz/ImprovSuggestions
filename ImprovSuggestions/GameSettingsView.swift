import SwiftUI

struct GameSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        SuggestionCardView {
                            SectionHeaderView(text: "GAMES")

                            Text("Choose which games appear on the Games tab.")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)

                            ForEach(AppState.GameMode.allCases) { game in
                                gameToggleRow(game)
                            }
                        }
                    }
                    .padding(32)
                }
            }
            .navigationTitle("Games Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private func gameToggleRow(_ game: AppState.GameMode) -> some View {
        let isEnabled = appState.isGameEnabled(game)

        return Button {
            appState.setGame(game, enabled: !isEnabled)
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isEnabled ? "checkmark.square.fill" : "square")
                    .font(.title3)
                    .foregroundStyle(isEnabled ? Color.theme.accentSoftBlue : Color.gray)

                Text(game.rawValue)
                    .font(.body)
                    .foregroundStyle(Color.theme.offWhite)

                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("game_toggle_\(game.rawValue)")
    }
}

#Preview {
    GameSettingsView()
        .environment(AppState())
}
