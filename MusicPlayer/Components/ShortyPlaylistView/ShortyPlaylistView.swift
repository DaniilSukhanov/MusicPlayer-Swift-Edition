//
//  ShortyPlaylistView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ShortyPlaylistView: View {
    let model: ShortlyPlaylistModel
    
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
            AppImage.chevronRight
                .foregroundStyle(AppColor.white)
                .font(.system(size: 14, weight: .regular))
        }
    }
}

#Preview {
    let model = ShortlyPlaylistModel(
        backendyID: "0",
        name: "Playlist",
        artists: [.init(id: "2", name: "733"), .init(id: "1", name: "3")],
        image: AppImage.noImage
    )
    return ZStack {
        Color.blue.ignoresSafeArea()
        ShortyPlaylistView(model: model)
    }
}
