import SwiftData
import SwiftUI

struct WordModeView: View {
    private let selectableCategories: [Category] = [.object, .location, .profession, .emotion]

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]

    @State private var selectedCategory: Category = .object
    @State private var currentSuggestion: SuggestionItem?
    @State private var suggestionQueueManagers: [String: SuggestionQueueManager] = [:]

    private var filteredSuggestions: [SuggestionItem] {
        suggestions.filter { $0.matchesCategory(selectedCategory) }
    }

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
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
                                    generateSuggestion()
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(selectedCategory == category ? .white : Color.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(selectedCategory == category ? Color.theme.accentDeepBlue : Color.clear)
                                    .frame(height: 2)
                            }
                            .animation(.spring(), value: selectedCategory)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text(selectedCategory.displayName.uppercased())
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
            if currentSuggestion == nil || currentSuggestion?.category != selectedCategory {
                generateSuggestion()
            }
        }
    }

    private func generateSuggestion() {
        let categoryKey = selectedCategory.rawValue
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
