import SwiftData
import SwiftUI

struct WordModeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Query private var suggestions: [SuggestionItem]
    
    @State private var viewModel = WordModeViewModel()

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.selectableCategories) { category in
                            Button(category.displayName) {
                                guard viewModel.longPressedCategory != category else {
                                    viewModel.longPressedCategory = nil
                                    return
                                }

                                withAnimation(.spring()) {
                                    viewModel.toggleCategory(category)
                                    viewModel.generateSuggestion()
                                }
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(viewModel.selectedCategories.contains(category) ? .white : Color.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(viewModel.selectedCategories.contains(category) ? Color.theme.accentDeepBlue : Color.clear)
                                    .frame(height: 2)
                            }
                            .animation(.spring(), value: viewModel.selectedCategories)
                            .simultaneousGesture(
                                LongPressGesture().onEnded { _ in
                                    withAnimation(.spring()) {
                                        viewModel.longPressedCategory = category
                                        viewModel.selectOnlyCategory(category)
                                        viewModel.generateSuggestion()
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }

                SuggestionCardView(trailingPadding: 28) {
                    SectionHeaderView(text: viewModel.selectedCategoryLabel)

                    Text(viewModel.currentSuggestion?.content ?? "Tap Generate")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("suggestion_text")
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        HapticManager.impact(.medium)
                        viewModel.toggleFavorite(persistenceAlertManager: persistenceAlertManager)
                    } label: {
                        Image(systemName: viewModel.currentSuggestion?.isFavorite == true ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(viewModel.currentSuggestion?.isFavorite == true ? Color.theme.accentPurple : Color.gray.opacity(0.65))
                            .padding(16)
                    }
                    .disabled(viewModel.currentSuggestion == nil)
                    .opacity(viewModel.currentSuggestion == nil ? 0.5 : 1)
                    .accessibilityIdentifier("favorite_button")
                }

                Button("Generate") {
                    HapticManager.impact(.light)
                    viewModel.generateSuggestion()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("generate_button")
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.updateSuggestions(suggestions)
        }
        .onChange(of: suggestions) { _, newSuggestions in
            viewModel.updateSuggestions(newSuggestions)
        }
    }
}

#Preview {
    WordModeView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
