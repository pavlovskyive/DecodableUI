//
//  DecodableLabel.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public struct DecodableLabel: View {

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

    public var body: some View {
        Text(text)
            .font(font)
            .minimumScaleFactor(0.7)
            .lineLimit(lineLimit)
            .foregroundColor(fontColor ?? .primary)
            .optionalModifier(viewModifier)
    }

    public init(
        text: String,
        fontSize: CGFloat? = nil,
        lineLimit: Int? = nil,
        fontColor: Color? = nil,
        viewModifier: DefaultDecodableViewModifier? = nil
    ) {
        self.text = text
        self.fontSize = fontSize
        self.lineLimit = lineLimit
        self.fontColor = fontColor
        self.viewModifier = viewModifier
    }

}
