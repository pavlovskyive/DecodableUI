//
//  DecodableLabel.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public struct DecodableLabel: DecodableView {

    private let text: String
    private let fontSize: CGFloat?
    private let lineLimit: Int?
    private let fontColor: Color?
    private var viewModifier: DefaultDecodableViewModifier?

    private var font: Font? {
        guard let fontSize = fontSize else {
            return .system(.body)
        }

        return .system(size: fontSize)
    }

    public var anyView: AnyView {
        AnyView(
            Text(text)
                .font(font)
                .minimumScaleFactor(0.7)
                .lineLimit(lineLimit)
                .foregroundColor(fontColor ?? .primary)
                .optionalModifier(viewModifier)
        )
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        guard let container = try? decoder?.container(keyedBy: CodingKeys.self),
              let text = try? container.decode(String.self, forKey: .text) else {
            return nil
        }
        self.text = text

        self.fontSize = try? container.decode(CGFloat.self, forKey: .fontSize)
        self.lineLimit = try? container.decode(Int.self, forKey: .lineLimit)
        self.fontColor = try? container.decodeColorFromHexString(forKey: .fontColor)

        viewModifier = DefaultDecodableViewModifier(from: decoder)
    }

}

private extension DecodableLabel {

    enum CodingKeys: String, CodingKey {
        case text
        case fontSize
        case lineLimit
        case fontColor
    }

}
