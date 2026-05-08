import SwiftData
import SwiftUI

struct WordModeView: View {
    private let selectableCategories: [Category] = [.object, .location, .profession, .emotion]

    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<SuggestionItem> { suggestion in
        suggestion.category == "object" ||
        suggestion.category == "location" ||
        suggestion.category == "profession" ||
        suggestion.category == "emotion"
    }) private var suggestions: [SuggestionItem]

    @State private var selectedCategory: Category = .object
    @State private var currentSuggestion: SuggestionItem?
    @State private var suggestionQueues: [String: [SuggestionItem]] = [:]

    private var filteredSuggestions: [SuggestionItem] {
        suggestions.filter { $0.category == selectedCategory.rawValue }
    }

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 32) {
                ModeHeaderCard(
                    title: "Word Mode",
                    subtitle: "Choose a category and generate a fresh prompt"
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selectableCategories) { category in
                            Button(category.displayName) {
                                withAnimation(.spring()) {
                                    selectedCategory = category
                                    suggestionQueues[category.rawValue] = []
                                    generateSuggestion()
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(selectedCategory == category ? .white : Color.gray)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(selectedCategory == category ? Color.theme.deepBlue : Color.clear)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(selectedCategory == category ? Color.clear : Color(red: 0.2, green: 0.2, blue: 0.2), lineWidth: 1)
                            }
                            .animation(.spring(), value: selectedCategory)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer()

                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(selectedCategory.displayName.uppercased())
                            .font(.sectionLabel)
                            .tracking(1.5)
                            .foregroundStyle(Color.theme.offWhite.opacity(0.55))

                        Text(currentSuggestion?.content ?? "Tap Generate")
                            .font(.suggestionTitle)
                            .foregroundStyle(Color.theme.offWhite)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.65)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color.theme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                    Button {
                        toggleFavorite()
                    } label: {
                        Image(systemName: currentSuggestion?.isFavorite == true ? "heart.fill" : "heart")
                            .font(.system(size: 34, weight: .semibold))
                            .foregroundStyle(currentSuggestion?.isFavorite == true ? Color.theme.brightRed : Color.theme.offWhite)
                            .frame(width: 58, height: 58)
                            .background(Color.theme.darkRed.opacity(0.35))
                            .clipShape(Circle())
                    }
                    .disabled(currentSuggestion == nil)
                    .opacity(currentSuggestion == nil ? 0.5 : 1)
                }

                Spacer()

                Button("Generate") {
                    generateSuggestion()
                }
                .buttonStyle(.primaryPill)
            }
            .padding(.vertical, 32)
        }
        .onAppear {
            if currentSuggestion == nil {
                generateSuggestion()
            }
        }
        .onChange(of: suggestions) { _, _ in
            if currentSuggestion == nil || currentSuggestion?.category != selectedCategory.rawValue {
                generateSuggestion()
            }
        }
    }

    private func generateSuggestion() {
        let categoryKey = selectedCategory.rawValue

        if suggestionQueues[categoryKey, default: []].isEmpty {
            suggestionQueues[categoryKey] = filteredSuggestions.shuffled()
        }

        currentSuggestion = suggestionQueues[categoryKey]?.popLast()
    }

    private func toggleFavorite() {
        guard let currentSuggestion else { return }
        currentSuggestion.isFavorite.toggle()

        do {
            try modelContext.save()
        } catch {
            assertionFailure("Failed to update favorite: \(error)")
        }
    }
}

private extension Category {
    var displayName: String {
        switch self {
        case .question:
            "Question"
        case .object:
            "Object"
        case .location:
            "Location"
        case .profession:
            "Profession"
        case .emotion:
            "Emotion"
        case .dialogueLine:
            "Dialogue"
        }
    }
}

#Preview {
    WordModeView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
