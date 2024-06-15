//
//  WelcomeView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var store: RootStore
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                AppImage.welcomeBackground
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    
                VStack {
                    Spacer()
                    Text("Feel the beat")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundStyle(AppColor.white)
                        .padding(.bottom, 16)
                    Text("Emmerse yourself into the\nworld of music today")
                        .font(.system(size: 16))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 51)
                    Button(action: { withAnimation { store.dispatch(.welcomeView(action: .continue)) } }) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AppColor.gradientBackground)
                            .frame(maxWidth: 203, maxHeight: 48)
                            .overlay {
                                Text("Continue")
                                    .foregroundStyle(AppColor.white)
                                    .fontWeight(.semibold)
                            }
                    }.padding(.bottom, 74)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
