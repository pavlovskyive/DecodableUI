//
//  DecodableImage+DecodableView.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

extension DecodableImage: DecodableView where Modifier: DecodableViewModifier {

    public var anyView: AnyView {
        AnyView(
            body
        )
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        let container = try? decoder?.container(keyedBy: CodingKeys.self)

        let url = try? container?.decode(URL.self, forKey: .url)
        let systemName = try? container?.decode(String.self, forKey: .systemName)

        let viewModifier = Modifier(from: decoder)

        self.init(
            url: url,
            systemName: systemName,
            viewModifier: viewModifier
        )
    }

    private enum CodingKeys: String, CodingKey {
        case systemName
        case url
    }

}
