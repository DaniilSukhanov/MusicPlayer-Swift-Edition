//
//  ContentList.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import SwiftUI

struct ContentList: View {
    @EnvironmentObject var store: RootStore
    let content: [ContentModel]
    let axis: Axis
    
    init(content: [ContentModel], axis: Axis = .vertical) {
        self.content = content
        self.axis = axis
    }
    
    @ViewBuilder var body: some View {
        let content = ForEach(content) { model in
            contentView(model: model)
        }
        if axis == .vertical {
            VStack(alignment: .center, spacing: 24, content: { content })
        } else {
            HStack(alignment: .top, spacing: 24, content: { content })
        }
    }
    
    @ViewBuilder func contentView(model: ContentModel) -> some View {
        switch model.type {
        case .track:
            trackContent(model)
        case .playlist:
            playlistContent(model)
        }
    }
    
    private func trackContent(_ model: ContentModel) -> some View {
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
                Text(model.artists?.compactMap({ $0.name }).joined(separator: ", ") ?? "None")
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
    
    private func playlistContent(_ model: ContentModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            model.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 208, maxHeight: 208)
                .clipShape(.rect(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 4) {
                Text(model.name)
                    .foregroundStyle(AppColor.white)
                    .font(.system(size: 18, weight: .semibold))
                Text(model.artists?.compactMap({ $0.name }).joined(separator: ", ") ?? "None")
                    .foregroundStyle(AppColor.lightGray)
                    .font(.system(size: 14, weight: .regular))
                    .lineLimit(1)
            }
        }
        
    }
}

#Preview {
    ContentList(content: [])
}
