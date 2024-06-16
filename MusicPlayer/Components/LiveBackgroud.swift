//
//  LiveBackgroud.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import SwiftUI

struct LiveBackgroud: View {
    let size: CGSize
    @State private var position: UnitPoint = .center
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    init(size: CGSize) {
        self.size = size

    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppColor.purple2,
                            AppColor.dark
                        ],
                        center: position,
                        startRadius: 0,
                        endRadius: min(size.width, size.height)
                    )
                )
            Rectangle()
                .fill(.ultraThinMaterial)
        }.onReceive(timer) { _ in
            withAnimation(.easeOut(duration: 10)) {
                position = .init(x: .random(in: 0...1), y: .random(in: 0...1))
            }
        }.onAppear {
            position = .init(x: .random(in: 0...1), y: .random(in: 0...1))
            withAnimation(.easeOut(duration: 10)) {
                position = .init(x: .random(in: 0...1), y: .random(in: 0...1))
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        LiveBackgroud(size: geometry.size)
            
    }.ignoresSafeArea()
}
