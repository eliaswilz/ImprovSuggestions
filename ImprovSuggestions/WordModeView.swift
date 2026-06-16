import SwiftData
import SwiftUI

struct WordModeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var persistenceAlertManager: PersistenceAlertManager
    @Environment(AppState.self) private var appState
    @State private var isShowingSettings = false

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            GeometryReader { geometry in
                ScrollView {
                    SuggestionCardView {
                        SectionHeaderView(text: appState.selectedCategoryLabel)

                        Text(appState.currentSuggestion?.content ?? "Tap Generate")
                            .font(.readableTitle)
                            .foregroundStyle(Color.theme.offWhite)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.5)
                            .accessibilityIdentifier("suggestion_text")
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                    .frame(minHeight: geometry.size.height, alignment: .center)
                }
            }

            VStack(spacing: 16) {
                Spacer()

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

                Button("Generate") {
                    HapticManager.impact(.light)
                    appState.generateWordSuggestion()
                }
                .buttonStyle(.primaryPill)
                .accessibilityIdentifier("generate_button")
            }
            .padding(32)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityIdentifier("word_settings_button")
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            WordSettingsView()
        }
    }
}

#Preview {
    WordModeView()
        .environmentObject(PersistenceAlertManager.shared)
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
