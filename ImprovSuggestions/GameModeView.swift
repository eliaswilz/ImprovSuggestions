import SwiftData
import SwiftUI

struct GameModeView: View {
    private enum GameMode: String, CaseIterable, Identifiable {
        case firstLineLastLine = "First Line, Last Line"
        case changingEmotions = "Changing Emotions"

        var id: String { rawValue }
    }

    @Query private var suggestions: [SuggestionItem]

    @State private var selectedGame: GameMode = .firstLineLastLine
    @State private var dialogueLine: SuggestionItem?
    @State private var emotions: [SuggestionItem] = []
    @State private var dialogueLineQueueManager = SuggestionQueueManager()

    private var dialogueLines: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.dialogueLine) }
    }

    private var emotionSuggestions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(.emotion) }
    }

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 32) {
                ModeHeaderCard(
                    title: "Game Mode",
                    subtitle: "Select a structure and regenerate playable ideas"
                )

                Picker("Game", selection: $selectedGame) {
                    ForEach(GameMode.allCases) { game in
                        Text(game.rawValue).tag(game)
                    }
                }
                .pickerStyle(.menu)
                .font(.readableHeadline)
                .tint(Color.theme.offWhite)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(Color.theme.deepBlue)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Group {
                    switch selectedGame {
                    case .firstLineLastLine:
                        firstLineLastLineView
                    case .changingEmotions:
                        changingEmotionsView
                    }
                }

                Spacer()

                Button(selectedGame == .firstLineLastLine ? "Regenerate" : "Regenerate") {
                    HapticManager.impact(.light)
                    regenerateCurrentGame()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("regenerate_button")
            }
            .padding(.vertical, 32)
        }
        .onAppear {
            regenerateCurrentGame()
        }
        .onChange(of: selectedGame) { _, _ in
            regenerateCurrentGame()
        }
        .onChange(of: suggestions) { _, _ in
            regenerateCurrentGame()
        }
    }

    private var firstLineLastLineView: some View {
        VStack(spacing: 24) {
            lineCard(title: "First Line:", text: dialogueLine?.content ?? "No dialogue lines available")
            lineCard(title: "Last Line:", text: dialogueLine?.secondaryContent ?? "No last line available")
        }
    }

    private var changingEmotionsView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(emotions.enumerated()), id: \.element.id) { index, emotion in
                    HStack(spacing: 16) {
                        Text("\(index + 1)")
                            .font(.readableBody)
                            .foregroundStyle(Color.theme.offWhite.opacity(0.65))
                            .frame(width: 36, alignment: .trailing)

                        Text(emotion.content)
                            .font(.readableBody)
                            .foregroundStyle(Color.theme.offWhite)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityIdentifier("emotion_text_\(index + 1)")
                    }
                    .padding(20)
                    .background(Color.theme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            .padding(.vertical, 32)
        }
    }

    private func lineCard(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title.uppercased())
                .font(.sectionLabel)
                .tracking(1.5)
                .foregroundStyle(Color.theme.offWhite.opacity(0.55))

            Text(text)
                .font(.title.weight(.bold))
                .foregroundStyle(Color.theme.offWhite)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.5)
                .accessibilityIdentifier(title.hasPrefix("First") ? "first_line_text" : "last_line_text")
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func regenerateCurrentGame() {
        switch selectedGame {
        case .firstLineLastLine:
            dialogueLine = dialogueLineQueueManager.next(from: dialogueLines)
        case .changingEmotions:
            emotions = Array(emotionSuggestions.shuffled().prefix(15))
        }
    }
}

#Preview {
    GameModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
