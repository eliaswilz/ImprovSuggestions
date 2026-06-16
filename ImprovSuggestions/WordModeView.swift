import SwiftData
import SwiftUI

struct WordModeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Environment(AppState.self) private var appState
    
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

                SuggestionCardView {
                    SectionHeaderView(text: appState.selectedCategoryLabel)

                    Text(appState.currentSuggestion?.content ?? "Tap Generate")
                        .font(.readableTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .accessibilityIdentifier("suggestion_text")
                }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
            }

            VStack {
                Spacer()

                Button("Generate") {
                    HapticManager.impact(.light)
                    appState.generateWordSuggestion()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("generate_button")
                .padding(32)
            }
        }
    }
}

#Preview {
    WordModeView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
