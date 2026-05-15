import SwiftData
import SwiftUI

struct WordModeView: View {
    private let selectableCategories: [Category] = [.object, .location, .profession, .emotion]

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]

    @State private var selectedCategories: Set<Category> = [.object]
    @State private var currentSuggestion: SuggestionItem?
    @State private var suggestionQueueManagers: [String: SuggestionQueueManager] = [:]
    @State private var longPressedCategory: Category?

    private var filteredSuggestions: [SuggestionItem] {
        suggestions.filter { selectedCategories.contains($0.category) && !$0.isMissingStoredCategory }
    }

    private var selectedCategoryLabel: String {
        guard !selectedCategories.isEmpty else { return "No Categories Selected" }

        return selectableCategories
            .filter { selectedCategories.contains($0) }
            .map(\.displayName)
            .joined(separator: ", ")
    }

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selectableCategories) { category in
                            Button(category.displayName) {
                                guard longPressedCategory != category else {
                                    longPressedCategory = nil
                                    return
                                }

                                withAnimation(.spring()) {
                                    toggleCategory(category)
                                    generateSuggestion()
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(selectedCategories.contains(category) ? .white : Color.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(selectedCategories.contains(category) ? Color.theme.accentDeepBlue : Color.clear)
                                    .frame(height: 2)
                            }
                            .animation(.spring(), value: selectedCategories)
                            .simultaneousGesture(
                                LongPressGesture().onEnded { _ in
                                    withAnimation(.spring()) {
                                        longPressedCategory = category
                                        selectOnlyCategory(category)
                                        generateSuggestion()
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text(selectedCategoryLabel.uppercased())
                        .font(.sectionLabel)
                        .tracking(1.5)
                        .foregroundStyle(Color.theme.accentSage)

                    Text(currentSuggestion?.content ?? "Tap Generate")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("suggestion_text")
                }
                .padding(32)
                .padding(.trailing, 28)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.theme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(alignment: .topTrailing) {
                    Button {
                        HapticManager.impact(.medium)
                        toggleFavorite()
                    } label: {
                        Image(systemName: currentSuggestion?.isFavorite == true ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(currentSuggestion?.isFavorite == true ? Color.theme.accentPurple : Color.gray.opacity(0.65))
                            .padding(16)
                    }
                    .disabled(currentSuggestion == nil)
                    .opacity(currentSuggestion == nil ? 0.5 : 1)
                    .accessibilityIdentifier("favorite_button")
                }

                Button("Generate") {
                    HapticManager.impact(.light)
                    generateSuggestion()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("generate_button")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }
        }
        .onAppear {
            if currentSuggestion == nil {
                generateSuggestion()
            }
        }
        .onChange(of: suggestions) { _, _ in
            if currentSuggestion == nil || !selectedCategories.contains(currentSuggestion?.category ?? .question) {
                generateSuggestion()
            }
        }
    }

    private func toggleCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    private func selectOnlyCategory(_ category: Category) {
        if selectedCategories.subtracting([category]).isEmpty == false {
            HapticManager.impact(.medium)
        }

        selectedCategories = [category]
    }

    private func generateSuggestion() {
        guard !selectedCategories.isEmpty else {
            currentSuggestion = nil
            return
        }

        let categoryKey = selectableCategories
            .filter { selectedCategories.contains($0) }
            .map(\.rawValue)
            .joined(separator: "|")
        var queueManager = suggestionQueueManagers[categoryKey] ?? SuggestionQueueManager()

        currentSuggestion = queueManager.next(from: filteredSuggestions)
        suggestionQueueManagers[categoryKey] = queueManager
    }

    private func toggleFavorite() {
        guard let currentSuggestion else { return }
        currentSuggestion.isFavorite.toggle()

        do {
            try modelContext.save()
        } catch {
            currentSuggestion.isFavorite.toggle()
            persistenceAlertManager.showSaveError(
                action: "Your favorite change could not be saved.",
                error: error
            )
        }
    }
}

#Preview {
    WordModeView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
