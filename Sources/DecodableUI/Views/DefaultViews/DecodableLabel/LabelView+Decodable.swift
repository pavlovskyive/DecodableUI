//
//  DecodableLabel+Decodable.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

extension LabelView: DecodableView where Modifier: DecodableViewModifier {

    public var anyView: AnyView {
        AnyView(body)
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        guard let container = try? decoder?.container(keyedBy: CodingKeys.self),
              let text = try? container.decode(String.self, forKey: .text) else {
            return nil
        }

        let fontSize = try? container.decode(CGFloat.self, forKey: .fontSize)
        let lineLimit = try? container.decode(Int.self, forKey: .lineLimit)
        let fontColor = try? container.decodeColorFromHexString(forKey: .fontColor)

        let viewModifier = Modifier(from: decoder)

        self.init(
            text: text,
            fontSize: fontSize,
            lineLimit: lineLimit,
            fontColor: fontColor,
            viewModifier: viewModifier
        )
    }

    private enum CodingKeys: String, CodingKey {
        case text
        case fontSize
        case lineLimit
        case fontColor
    }

}
