import SwiftUI

struct HowToPlayView: View {
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
    HowToPlayView()
}
