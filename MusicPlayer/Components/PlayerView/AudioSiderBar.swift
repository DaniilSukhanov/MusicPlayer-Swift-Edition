//
//  AudioSliderBar.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import SwiftUI
import AVFoundation

struct AudioSliderBar: View {
    @EnvironmentObject var store: RootStore
    private var player: AVAudioPlayer? {
        store.state.playerState.player
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let currentTime = store.state.playerState.currentTime ?? 0
            let duration = player?.duration ?? 0
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(AppColor.lightGray)
                    Rectangle()
                        .fill(AppColor.white)
                        .frame(width: maxWidth*(currentTime/duration))
                }
                .clipShape(.rect(cornerRadius: 25))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let time = Double(value.location.x/maxWidth)*duration
                            store.dispatch(.player(action: .moveSlider(to: time)))
                        }
                )
                HStack {
                    Text(currentTime.toString() ?? "--:--")
                        .foregroundStyle(AppColor.white)
                        .font(.system(size: 14, weight: .regular))
                        .animation(.easeIn, value: currentTime)
                    Spacer()
                    Text(duration.toString() ?? "--:--")
                        .foregroundStyle(AppColor.white)
                        .font(.system(size: 14, weight: .regular))
                }
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
        Color.red.ignoresSafeArea()
        AudioSliderBar()
            .frame(width: 300, height: 60)
            .environmentObject(store)
    }
    
}
