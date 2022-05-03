//
//  DecodableImage.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 29.04.2022.
//

import SwiftUI

public struct DecodableImage: View {

    private let url: URL?
    private let systemName: String?

    private let viewModifier: DefaultDecodableViewModifier?

    public var body: some View {
        image
            .aspectRatio(contentMode: .fill)
            .optionalModifier(viewModifier)
    }

    public init(
        url: URL? = nil,
        systemName: String? = nil,
        viewModifier: DefaultDecodableViewModifier? = nil
    ) {
        self.url = url
        self.systemName = systemName
        self.viewModifier = viewModifier
    }

}

private extension DecodableImage {

    @ViewBuilder
    var image: some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .image(let image):
                    image.resizable()
                case .error:
                    errorImage
                case .loading:
                    loadingView
                }
            }
        } else {
            systemImage
        }
    }

    @ViewBuilder
    var systemImage: some View {
        if let systemName = systemName {
            Image(systemName: systemName)
        }
    }

    var errorImage: some View {
        Image(systemName: "exclamationmark.triangle")
    }

    var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }

}
