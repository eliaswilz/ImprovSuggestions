//
//  ContentView.swift
//  ImprovSuggestions
//
//  Created by Elias Wilz on 5/7/26.
//

import SwiftUI

struct ContentView: View {
    init() {
        let backgroundColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1.0)
        let borderColor = UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1.0)
        let activeColor = UIColor(red: 0.000, green: 0.412, blue: 0.616, alpha: 1.0)
        let inactiveColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1.0)
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
        TabView {
            QuestionModeView()
                .tabItem {
                    Label("Questions", systemImage: "questionmark.bubble")
                }

            WordModeView()
                .tabItem {
                    Label("Words", systemImage: "textformat.abc")
                }

            GameModeView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .tint(Color.theme.brightBlue)
        .toolbarBackground(Color.theme.darkBackground, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .background(Color.theme.darkBackground)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
