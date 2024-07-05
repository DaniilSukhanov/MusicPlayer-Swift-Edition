//
//  ContentListView.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ContentListView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let axis: Axis
    let data: Data
    @ViewBuilder let view: (Data.Element) -> Content
    
    var body: some View {
        let content = ForEach(data, id: \.id) { element in
            view(element)
        }
        if axis == .vertical {
            VStack(alignment: .center, spacing: 24, content: { content })
        } else {
            HStack(alignment: .top, spacing: 24, content: { content })
        }
    }
}

#Preview {
    enum TestModel: Int, Identifiable {
        var id: Int { self.rawValue }
        
        case test1
        case test2
    }
    let data = [TestModel.test1, TestModel.test2, TestModel.test1, TestModel.test2]
    return ContentListView(axis: .vertical, data: data) { model in
        if model == .test1 {
            Text("test1: \(model.id)")
        } else {
            Text("test2: \(model.id)")
                .bold()
        }
    }
}
