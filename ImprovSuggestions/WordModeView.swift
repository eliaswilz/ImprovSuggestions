import SwiftData
import SwiftUI

struct WordModeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Environment(AppState.self) private var appState
    @Query private var suggestions: [SuggestionItem]
    
    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(appState.selectableWordCategories) { category in
                            Button(category.displayName) {
                                guard appState.longPressedCategory != category else {
                                    appState.longPressedCategory = nil
                                    return
                                }

                                withAnimation(.spring()) {
                                    appState.toggleCategory(category)
                                    appState.generateWordSuggestion()
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(appState.selectedCategories.contains(category) ? .white : Color.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(appState.selectedCategories.contains(category) ? Color.theme.accentDeepBlue : Color.clear)
                                    .frame(height: 2)
                            }
                            .animation(.spring(), value: appState.selectedCategories)
                            .simultaneousGesture(
                                LongPressGesture().onEnded { _ in
                                    withAnimation(.spring()) {
                                        appState.longPressedCategory = category
                                        appState.selectOnlyCategory(category)
                                        appState.generateWordSuggestion()
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }

                SuggestionCardView(trailingPadding: 28) {
                    SectionHeaderView(text: appState.selectedCategoryLabel)

                    Text(appState.currentSuggestion?.content ?? "Tap Generate")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("suggestion_text")
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        HapticManager.impact(.medium)
                        appState.toggleFavorite(persistenceAlertManager: persistenceAlertManager)
                    } label: {
                        Image(systemName: appState.currentSuggestion?.isFavorite == true ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(appState.currentSuggestion?.isFavorite == true ? Color.theme.accentPurple : Color.gray.opacity(0.65))
                            .padding(16)
                    }
                    .disabled(appState.currentSuggestion == nil)
                    .opacity(appState.currentSuggestion == nil ? 0.5 : 1)
                    .accessibilityIdentifier("favorite_button")
                }

                Button("Generate") {
                    HapticManager.impact(.light)
                    appState.generateWordSuggestion()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("generate_button")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }
        }
        .onAppear {
            appState.setModelContext(modelContext)
            appState.suggestions = suggestions
        }
        .onChange(of: suggestions) { _, newSuggestions in
            appState.suggestions = newSuggestions
        }
    }
}

#Preview {
    WordModeView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
