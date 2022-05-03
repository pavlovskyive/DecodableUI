//
//  DefaultDecodableViewModifier.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

public protocol DecodableViewModifier: ViewModifier {

    init?(from decoder: Decoder?)

}

public struct DefaultViewModifier: ViewModifier {

    private let background: Color
    private let cornerRadius: CGFloat

    private let padding: CGFloat?
    private let width: CGFloat?
    private let height: CGFloat?

    public func body(content: Content) -> some View {
        content
            .padding(padding ?? 0)
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(cornerRadius)
    }

    init(
        background: Color? = nil,
        padding: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        self.background = background ?? .clear
        self.cornerRadius = cornerRadius ?? 0

        self.padding = padding
        self.width = width
        self.height = height
    }

}

extension DefaultViewModifier: DecodableViewModifier {

    enum CodingKeys: String, CodingKey {
        case background
        case padding
        case cornerRadius
        case width
        case height
    }

    public init?(from decoder: Decoder?) {
        guard let container = try? decoder?.container(keyedBy: CodingKeys.self) else {
            return nil
        }

        let background = try? container.decodeColorFromHexString(forKey: .background)
        let padding = try? container.decode(CGFloat.self, forKey: .padding)
        let cornerRadius = try? container.decode(CGFloat.self, forKey: .cornerRadius)
        let width = try? container.decode(CGFloat.self, forKey: .width)
        let height = try? container.decode(CGFloat.self, forKey: .height)

        self.init(
            background: background,
            padding: padding,
            cornerRadius: cornerRadius,
            width: width,
            height: height
        )
    }

}
