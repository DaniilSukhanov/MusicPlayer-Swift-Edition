//
//  ShortyArtistView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ShortyArtistView: View {
    let model: ShortyArtistModel
    
    var body: some View {
        HStack(alignment: .center, spacing: nil) {
            model.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 56, maxHeight: 56)
                .clipShape(.circle)
                .padding(.trailing, 16)
                
                
            VStack(alignment: .leading, spacing: 4) {
                Text(model.name)
                    .foregroundStyle(AppColor.white)
                    .font(.system(size: 18, weight: .semibold))
                Text("Artist")
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
    let model = ShortyArtistModel(
        backendyID: UUID().uuidString,
        name: "Dima Bilan",
        image: AppImage.noImage
    )
    return ZStack {
        Color.blue
            .ignoresSafeArea()
        ShortyArtistView(model: model)
    }
}
