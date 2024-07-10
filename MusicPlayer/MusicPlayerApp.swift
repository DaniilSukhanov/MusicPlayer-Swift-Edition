//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 09.06.2024.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct MusicPlayerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var store: RootStore = createRootStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(store)
    }
}
