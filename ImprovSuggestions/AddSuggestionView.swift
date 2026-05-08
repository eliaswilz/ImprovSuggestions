import SwiftData
import SwiftUI

struct AddSuggestionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var content = ""
    @State private var secondaryContent = ""
    @State private var selectedCategory: Category = .question

    private var trimmedContent: String {
        content.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedSecondaryContent: String {
        secondaryContent.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Suggestion") {
                    TextField("Main content", text: $content, axis: .vertical)
                        .lineLimit(2...5)

                    TextField("Secondary content (optional)", text: $secondaryContent, axis: .vertical)
                        .lineLimit(1...4)
                }

                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.displayName).tag(category)
                        }
                    }
                }
            }
            .navigationTitle("Add Suggestion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSuggestion()
                    }
                    .disabled(trimmedContent.isEmpty)
                }
            }
        }
    }

    private func saveSuggestion() {
        let suggestion = SuggestionItem(
            content: trimmedContent,
            secondaryContent: trimmedSecondaryContent.isEmpty ? nil : trimmedSecondaryContent,
            category: selectedCategory,
            isCustom: true
        )

        modelContext.insert(suggestion)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            assertionFailure("Failed to save custom suggestion: \(error)")
        }
    }
}

#Preview {
    AddSuggestionView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
