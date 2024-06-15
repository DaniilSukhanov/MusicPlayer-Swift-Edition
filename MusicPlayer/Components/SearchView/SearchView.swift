//
//  SearchView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 14.06.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        TextField("", text: $searchText)
            .background {
                ZStack {
                    Image.search
                        .opacity(searchText.isEmpty ? 0.3 : 0)
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.white)
                        .padding()
                    
                }
            }
    }
}

#Preview {
    ZStack {
        Color.red
            .ignoresSafeArea()
        SearchView()
            .frame(height: 50)
            .padding(.leading, 50)
            .padding(.trailing, 50)
    }
        
}
