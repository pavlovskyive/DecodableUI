//
//  DecodableStack+Decodable.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

extension StackView: DecodableView where Modifier: DecodableViewModifier {

    public var anyView: AnyView {
        AnyView(body)
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        guard let container = try? decoder?.container(keyedBy: CodingKeys.self),
              let direction = try? container.decode(Direction.self, forKey: .direction),
              let configurations = try? container.decode([DecodableViewConfiguration].self, forKey: .elements) else {
                  return nil
              }

        let elements = configurations.compactMap { configuration in
            viewResolver.resolve(from: configuration)?.anyView
        }
        let alignment = try? container.decode(Alignment.self, forKey: .alignment)
        let spacing = try? container.decode(CGFloat.self, forKey: .spacing)

        let viewModifier = Modifier(from: decoder)

        self.init(
            direction: direction,
            spacing: spacing,
            alignment: alignment,
            viewModifier: viewModifier,
            elements: elements
        )
    }

    private enum CodingKeys: String, CodingKey {
        case direction
        case alignment
        case spacing
        case elements
    }

}
