import SwiftUI

struct WordSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        SuggestionCardView {
                            SectionHeaderView(text: "TIP")

                            Text("Press and hold a category to deselect all other categories.")
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .padding(32)
                }
            }
            .navigationTitle("Words Settings")
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
    WordSettingsView()
}
