//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var store: RootStore
    private var state: PlayerState {
        store.state.playerState
    }
    private var currentPlayerItem: PlayerItem? {
        state.queue.currentAudio
    }
    
    @ViewBuilder var body: some View {
        VStack {
            if let currentPlayerItem {
                VStack {
                    trackView(model: currentPlayerItem.model)
                }
            } else {
                Text("Error")
            }
            AudioSliderBar()
                .frame(minHeight: 40)
            bottomButtonPanel
        }
    }
}

fileprivate extension PlayerView {
    func trackView(model: ShortlyTrackModel) -> some View {
        VStack(alignment: .leading) {
            model.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 342, maxHeight: 342)
                .clipShape(.rect(cornerRadius: 25))
            VStack(alignment: .leading, spacing: 8) {
                Text(model.name)
                    .foregroundStyle(AppColor.white)
                    .font(.system(size: 24, weight: .bold))
                Text(model.artists.compactMap({ $0.name }).joined(separator: ", "))
                    .foregroundStyle(AppColor.lightGray)
                    .font(.system(size: 16, weight: .semibold))
                
            }
        }
    }
}

fileprivate extension PlayerView {
    var bottomButtonPanel: some View {
        HStack {
            Button(action: { }) {
                AppImage.backward
                    .foregroundStyle(AppColor.white)
            }
            Button(action: { state.isPlaying ? store.dispatch(.player(action: .stop)) : store.dispatch(.player(action: .play)) }) {
                let image: Image = state.isPlaying ? AppImage.play : AppImage.pause
                image
                    .foregroundStyle(AppColor.white)
                
                
            }
            Button(action: { }) {
                AppImage.forward
                    .foregroundStyle(AppColor.white)
            }
        }
    }
}

#Preview {
    let store = createRootStore()
    store.dispatch(
        .player(
            action: .addPlayerItem(
                .init(
                    audio: loadTestAudio() ?? Data(), 
                    model: .init(backendyID: "123", name: "test", artists: [], duration: "3:31", image: AppImage.noImage)
                )
            )
        )
    )
    store.dispatch(.player(action: .updateCurrentTime))
    return ZStack {
        Color.red
            .ignoresSafeArea()
        PlayerView()
    }.environmentObject(store)
}
