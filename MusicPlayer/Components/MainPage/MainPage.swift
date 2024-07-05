//
//  MainPage.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import SwiftUI
import Combine

struct MainPage: View {
    @EnvironmentObject var store: RootStore
    @StateObject private var searchText = SearchText()
    @State private var carouselSelectedItem: CarouselItem = .recent
    @FocusState private var isFocusSearch: Bool
    @State private var isTrack = true
    
    var body: some View {
        ScrollView {
            VStack {
                header
                Button("isTrack: \(isTrack)") {
                    isTrack.toggle()
                }
                if let data = store.state.mainPageState.content {
                    ContentListView(axis: .vertical, data: data) { container in
                        if let model = container.value as? ShortlyTrackModel {
                            ShortyTrackView(model: model)
                        } else if let model = container.value as? ShortlyPlaylistModel {
                            ShortyPlaylistView(model: model)
                        } else {
                            EmptyView()
                        }
                    }
                }
            }.padding()
        }.onTapGesture {
            isFocusSearch = false
        }
    }
}

fileprivate extension MainPage {
    final class SearchText: ObservableObject {
        @Published var value = ""
    }
}

// MARK: - Header
fileprivate extension MainPage {
    var header: some View {
        VStack(spacing: 40) {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    HStack {
                        Text("Welcome back!")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(AppColor.white)
                        Spacer()
                    }
                    HStack {
                        Text("What do you feel like today?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(AppColor.lightGray)
                        Spacer()
                    }
                }
                search
            }
            carousel
        }
    }
}

// MARK: Search
fileprivate extension MainPage {
    var search: some View {
        HStack {
            AppImage.search
                .foregroundStyle(AppColor.lightGray)
            TextField(text: $searchText.value) {
                Text("Search song, playslist, artist...")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundStyle(AppColor.lightGray)
                    
            }.foregroundStyle(AppColor.lightGray)
                .focused($isFocusSearch)
                .onReceive(
                    searchText.$value
                        .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
                ) { value in
                    if !value.isEmpty {
                        store.dispatch(
                            .mainPageReducer(
                                action: .search(value, type: isTrack ? .tracks : .playlists)
                            )
                        )
                    }
                }
            
        }.padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(AppColor.darkGray)
            }
            .onTapGesture {
                isFocusSearch = true
            }
    }
}

//MARK: Carousel
fileprivate extension MainPage {
    enum CarouselItem: String, CaseIterable {
        case recent = "Recent"
        case top50 = "Top 50"
        case chill = "Chiil"
        case rAndB = "R&B"
        case festival = "Festival"
    }
    
    var carousel: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 32) {
                ForEach(CarouselItem.allCases, id: \.self) { item in
                    itemCarousel(text: item.rawValue, isSelected: item == carouselSelectedItem)
                        .onTapGesture {
                            withAnimation {
                                carouselSelectedItem = item
                            }
                        }
                }
            }
        }
    }
    
    @ViewBuilder func itemCarousel(text: String, isSelected: Bool) -> some View {
        VStack {
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(isSelected ? AppColor.white : AppColor.lightGray)
            Rectangle()
                .fill(LinearGradient(gradient: AppColor.gradientBackground, startPoint: .trailing, endPoint: .leading))
                .frame(maxHeight: 3.5)
                .opacity(isSelected ? 1 : 0)
        }
        
            
    }
}

#Preview {
    ZStack {
        Color.blue
        MainPage().padding()
    }.ignoresSafeArea()
}
