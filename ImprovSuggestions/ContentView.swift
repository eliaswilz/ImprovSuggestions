//
//  ContentView.swift
//  ImprovSuggestions
//
//  Created by Elias Wilz on 5/7/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Query private var suggestions: [SuggestionItem]

    init() {
        let backgroundColor = UIColor(Color.theme.darkBackground)
        let borderColor = UIColor(Color.theme.headerCardBackground)
        let activeColor = UIColor(Color.theme.accentSoftBlue)
        let inactiveColor = UIColor(Color.theme.accentSage)
        let labelFont = UIFont.systemFont(ofSize: 11, weight: .medium)
        let appearance = UITabBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowImage = nil
        appearance.shadowColor = borderColor

        appearance.stackedLayoutAppearance.selected.iconColor = activeColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: activeColor,
            .font: labelFont
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = inactiveColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: inactiveColor,
            .font: labelFont
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = activeColor
        UITabBar.appearance().unselectedItemTintColor = inactiveColor
    }

    var body: some View {
        NavigationStack {
            TabView {
                QuestionModeView()
                    .tabItem {
                        Label("Questions", systemImage: "questionmark.bubble")
                            .accessibilityIdentifier("questions_tab")
                    }

                WordModeView()
                    .tabItem {
                        Label("Words", systemImage: "textformat.abc")
                            .accessibilityIdentifier("words_tab")
                    }

                GameModeView()
                    .tabItem {
                        Label("Games", systemImage: "gamecontroller")
                            .accessibilityIdentifier("games_tab")
                    }

                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                            .accessibilityIdentifier("favorites_tab")
                    }

                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                            .accessibilityIdentifier("settings_tab")
                    }
            }
            .tint(Color.theme.accentSoftBlue)
            .toolbarBackground(Color.theme.darkBackground, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .background(Color.theme.darkBackground)
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
    ContentView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
