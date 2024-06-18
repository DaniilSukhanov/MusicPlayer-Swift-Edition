//
//  ContentList.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import SwiftUI

struct ContentList: View {
    let content: [ContentModel]
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(content) { model in
                trackContent(model)
                    .frame(maxHeight: 56)
            }
        }
    }
    
    private func trackContent(_ model: ContentModel) -> some View {
        HStack(alignment: .center, spacing: nil) {
            model.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 56, maxHeight: 56)
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
            Text(model.duration ?? "--:--")
                .foregroundStyle(AppColor.white)
                .font(.system(size: 14, weight: .regular))
        }
    }
}

#Preview {
    ContentList(content: [])
}
