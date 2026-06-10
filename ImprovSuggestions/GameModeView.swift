import SwiftData
import SwiftUI

struct GameModeView: View {
    @Environment(AppState.self) private var appState
    @Query private var suggestions: [SuggestionItem]
    
    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // Fixed Header: Game Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(AppState.GameMode.allCases) { game in
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
                    .padding(.horizontal, 32)
                }
                .padding(.vertical, 32)

                // Scrollable Content Area
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
                    .padding(.bottom, 24)
                }

                // Fixed Footer: Regenerate Button
                Button("Regenerate") {
                    HapticManager.impact(.light)
                    appState.regenerateCurrentGame()
                }
                .buttonStyle(.primaryPill)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                .accessibilityIdentifier("regenerate_button")
            }
        }
        .onAppear {
            appState.suggestions = suggestions
        }
        .onChange(of: suggestions) { _, newSuggestions in
            appState.suggestions = newSuggestions
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
