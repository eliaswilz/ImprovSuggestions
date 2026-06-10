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
    @StateObject private var persistenceAlertManager = PersistenceAlertManager.shared
    @State private var appState = AppState()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SuggestionItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            try DataManager.shared.preloadSuggestionsIfNeeded(modelContext: container.mainContext)
            return container
        } catch {
            print("Primary ModelContainer initialization failed. Crash reporter should log this error: \(error)")
            PersistenceAlertManager.shared.showSaveError(
                action: "The saved database could not be opened, so this launch is using a temporary in-memory store.",
                error: error
            )

            do {
                let fallbackConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                let fallbackContainer = try ModelContainer(for: schema, configurations: [fallbackConfiguration])
                try DataManager.shared.preloadSuggestionsIfNeeded(modelContext: fallbackContainer.mainContext)
                return fallbackContainer
            } catch {
                fatalError("Could not create fallback in-memory ModelContainer: \(error)")
            }
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(persistenceAlertManager)
                .environment(appState)
                .alert(item: $persistenceAlertManager.currentAlert) { alert in
                    Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
