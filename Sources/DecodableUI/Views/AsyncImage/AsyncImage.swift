//
//  AsyncImage.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

struct AsyncImage<Content: View>: View {

    @StateObject private var loader: ImageLoader
    private let content: (AsyncImagePhase) -> Content

    var body: some View {
        content(loader.phase)
            .onAppear(perform: loader.load)
    }

    init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.content = content
    }

}
