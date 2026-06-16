import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var expandedTitles: Set<String> = []

    private let games: [(title: String, text: String)] = [
        (
            title: "Changing Emotions",
            text: "Start a scene as normal. Throughout the scene, players are assigned a series of emotions to play, one after another. Each time a new emotion is called, the whole scene shifts so every character now plays that feeling, justifying the change through the story. Work through the list of emotions in order, committing fully to each one."
        ),
        (
            title: "First Line, Last Line",
            text: "Players are given the first line and the last line of a scene before they begin. They must open the scene with the exact first line and improvise their way forward so the scene ends naturally on the exact last line. The challenge is connecting the two with a story that makes both lines feel earned."
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(games.sorted { $0.title < $1.title }, id: \.title) { game in
                            gameRow(title: game.title, text: game.text)
                        }
                    }
                    .padding(32)
                }
            }
            .navigationTitle("Improv Games Guide")
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

    private func gameRow(title: String, text: String) -> some View {
        let isExpanded = expandedTitles.contains(title)

        return VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if isExpanded {
                        expandedTitles.remove(title)
                    } else {
                        expandedTitles.insert(title)
                    }
                }
            } label: {
                HStack {
                    Text(title.uppercased())
                        .font(.sectionLabel)
                        .tracking(1.5)
                        .foregroundStyle(Color.theme.accentSage)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.theme.accentSage)
                        .rotationEffect(.degrees(isExpanded ? 0 : -90))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(text)
                    .font(.body)
                    .foregroundStyle(Color.theme.offWhite)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    HowToPlayView()
}
