import SwiftUI

struct QuestionSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        SuggestionCardView {
                            SectionHeaderView(text: "NOTE")

                            Text("The Simulate Audience Response button isn't yet functional.")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .padding(32)
                }
            }
            .navigationTitle("Questions Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    QuestionSettingsView()
}
