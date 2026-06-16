import SwiftUI

struct QuestionSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()
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
