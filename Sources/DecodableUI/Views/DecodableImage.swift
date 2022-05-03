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
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle")
                    // the error here is "cancelled" on any view that wasn't visible at app launch
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                }
            }
            .optionalModifier(viewModifier)
        )
    }

    @ViewBuilder
    var systemImage: some View {
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
