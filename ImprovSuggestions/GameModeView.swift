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

            VStack(alignment: .leading, spacing: 0) {
                // Fixed Header: Game Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(GameMode.allCases) { game in
                            Button(game.rawValue) {
                                withAnimation(.spring()) {
                                    selectedGame = game
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(selectedGame == game ? .white : Color.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(selectedGame == game ? Color.theme.accentDeepBlue : Color.clear)
                                    .frame(height: 2)
                            }
                            .animation(.spring(), value: selectedGame)
                        }
                    }
                    .padding(.horizontal, 32)
                }
                .padding(.vertical, 32)

                // Scrollable Content Area
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        Group {
                            switch selectedGame {
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
                    regenerateCurrentGame()
                }
                .buttonStyle(.primaryPill)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                .accessibilityIdentifier("regenerate_button")
            }
        }
        .onAppear {
            if emotions.isEmpty {
                regenerateCurrentGame()
            }
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
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(emotions.enumerated()), id: \.element.id) { index, emotion in
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

                if index < emotions.count - 1 {
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
        VStack(alignment: .leading, spacing: 16) {
            Text(title.uppercased())
                .font(.sectionLabel)
                .tracking(1.5)
                .foregroundStyle(Color.theme.accentSage)

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
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
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
