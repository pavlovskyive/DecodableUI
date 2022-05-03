//
//  DecodableImage.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 29.04.2022.
//

import SwiftUI

public struct DecodableImage: DecodableView {

    private let url: URL?
    private let systemName: String?

    private let viewModifier: DefaultDecodableViewModifier?

    public var anyView: AnyView {
        AnyView(
            image
                .aspectRatio(contentMode: .fill)
                .optionalModifier(viewModifier)
        )
    }

    @ViewBuilder
    private var image: some View {
        if let url = url {
            AsyncImage(url: url) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
            }
        } else {
            systemImage
        }
    }

    @ViewBuilder
    private var systemImage: some View {
        if let systemName = systemName {
            Image(systemName: systemName)
        }
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        let container = try? decoder?.container(keyedBy: CodingKeys.self)

        url = try? container?.decode(URL.self, forKey: .url)
        systemName = try? container?.decode(String.self, forKey: .systemName)

        viewModifier = DefaultDecodableViewModifier(from: decoder)
    }

}

private extension DecodableImage {

    enum CodingKeys: String, CodingKey {
        case systemName
        case url
    }

}
