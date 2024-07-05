//
//  ShortyTrackView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ShortyTrackView: View {
    let model: ShortlyTrackModel
    
    var body: some View {
        HStack(alignment: .center, spacing: nil) {
            model.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 56, maxHeight: 56)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.trailing, 16)
                
                
            VStack(alignment: .leading, spacing: 4) {
                Text(model.name)
                    .foregroundStyle(AppColor.white)
                    .font(.system(size: 18, weight: .semibold))
                Text(model.artists.compactMap({ $0.name }).joined(separator: ", "))
                    .foregroundStyle(AppColor.lightGray)
                    .font(.system(size: 14, weight: .regular))
                    .lineLimit(1)
            }
            Spacer()
            Text(model.duration)
                .foregroundStyle(AppColor.white)
                .font(.system(size: 14, weight: .regular))
        }
    }
}

#Preview {
    let model = ShortlyTrackModel(
        backendyID: UUID().uuidString,
        name: "Hello",
        artists: [.init(id: "0", name: "Test")],
        duration: "06:56",
        image: AppImage.noImage
    )
    return ZStack {
        Color.blue
            .ignoresSafeArea()
        ShortyTrackView(model: model)
    }
}
