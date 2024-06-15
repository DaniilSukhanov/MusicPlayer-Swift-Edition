//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 09.06.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @EnvironmentObject var store: RootStore
    
    @ViewBuilder var content: some View {
        if store.state.welcomeViewState.isShowWelcomeView {
            WelcomeView()
                .transition(.opacity)
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        content
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
 
