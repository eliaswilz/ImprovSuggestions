import SwiftUI

struct GameModeView: View {
    @Environment(AppState.self) private var appState
    @State private var isShowingSettings = false

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Scrollable, vertically-centered Content Area
                GeometryReader { geometry in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 32) {
                            Group {
                                switch appState.selectedGame {
                                case .firstLineLastLine:
                                    firstLineLastLineView
                                case .changingEmotions:
                                    changingEmotionsView
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 32)
                        .frame(minHeight: geometry.size.height, alignment: .center)
                    }
                }

                // Spacer gap between scroll content and footer
                Spacer()
                    .frame(height: 16)

                // Fixed Footer: Game Selector + Regenerate Button
                VStack(spacing: 16) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(appState.availableGames) { game in
                                Button(game.rawValue) {
                                    withAnimation(.spring()) {
                                        appState.selectGame(game)
                                    }
                                }
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(appState.selectedGame == game ? .white : Color.gray)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 8)
                                .overlay(alignment: .bottom) {
                                    Rectangle()
                                        .fill(appState.selectedGame == game ? Color.theme.accentDeepBlue : Color.clear)
                                        .frame(height: 2)
                                }
                                .animation(.spring(), value: appState.selectedGame)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Button("Regenerate") {
                        HapticManager.impact(.light)
                        appState.regenerateCurrentGame()
                    }
                    .buttonStyle(.primaryPill)
                    .accessibilityIdentifier("regenerate_button")
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityIdentifier("game_settings_button")
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            GameSettingsView()
        }
    }

    private var firstLineLastLineView: some View {
        VStack(spacing: 24) {
            lineCard(title: "First Line:", text: appState.firstLine?.content ?? "No dialogue lines available")
            lineCard(title: "Last Line:", text: appState.lastLine?.content ?? "No last line available")
        }
    }

    private var changingEmotionsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(appState.emotions.enumerated()), id: \.element.id) { index, emotion in
                HStack(spacing: 16) {
                    Text("\(index + 1)")
                        .font(.caption.bold())
                        .foregroundStyle(Color.theme.accentOlive)
                        .frame(width: 20, alignment: .leading)

                    Text(emotion.content)
                        .font(.readableBody)
                        .foregroundStyle(Color.theme.offWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("emotion_text_\(index + 1)")
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 24)

                if index < appState.emotions.count - 1 {
                    Rectangle()
                        .fill(Color.theme.offWhite.opacity(0.05))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                }
            }
        }
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func lineCard(title: String, text: String) -> some View {
        SuggestionCardView {
            SectionHeaderView(text: title)

            Text(text)
                .font(.title.weight(.bold))
                .foregroundStyle(Color.theme.offWhite)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.5)
                .accessibilityIdentifier(title.hasPrefix("First") ? "first_line_text" : "last_line_text")
        }
    }
}

#Preview {
    GameModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
