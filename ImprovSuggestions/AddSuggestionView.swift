import SwiftData
import SwiftUI

struct AddSuggestionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager

    @State private var selectedCategory: Category = .object
    @State private var content = ""

    private let allowedCategories: [Category] = [.object, .location, .profession, .emotion]
    private let maxLength = 120

    private var characterCount: Int {
        content.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.darkBackground
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    SuggestionCardView(spacing: 16) {
                        SectionHeaderView(text: "CATEGORY")

                        Picker("Category", selection: $selectedCategory) {
                            ForEach(allowedCategories) { category in
                                Text(category.displayName)
                                    .tag(category)
                            }
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(Color.theme.accentDeepBlue)
                    }

                    SuggestionCardView(spacing: 16) {
                        SectionHeaderView(text: "SUGGESTION")

                        TextField("Enter suggestion...", text: $content, axis: .vertical)
                            .font(.body)
                            .foregroundStyle(Color.theme.offWhite)
                            .tint(Color.theme.accentSoftBlue)

                        HStack {
                            Spacer()
                            Text("\(characterCount) / \(maxLength)")
                                .font(.caption)
                                .foregroundStyle(characterCount > maxLength ? Color.theme.accentPurple : Color.gray)
                        }
                    }

                    Button("Save") {
                        saveSuggestion()
                    }
                    .buttonStyle(.primaryPill)
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || characterCount > maxLength)

                    Spacer()
                }
                .padding(32)
            }
            .navigationTitle("Add Suggestion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: content) { _, newValue in
            if newValue.count > maxLength {
                content = String(newValue.prefix(maxLength))
            }
        }
    }

    private func saveSuggestion() {
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        DataManager.shared.addCustomSuggestion(
            content: trimmed,
            category: selectedCategory,
            modelContext: modelContext,
            alertManager: persistenceAlertManager
        )
        dismiss()
    }
}

#Preview {
    AddSuggestionView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
