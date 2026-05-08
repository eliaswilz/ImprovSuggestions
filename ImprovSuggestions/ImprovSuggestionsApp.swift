//
//  ImprovSuggestionsApp.swift
//  ImprovSuggestions
//
//  Created by Elias Wilz on 5/7/26.
//

import SwiftUI
import SwiftData

@main
struct ImprovSuggestionsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SuggestionItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            DataManager.shared.preloadSuggestionsIfNeeded(modelContext: container.mainContext)
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
