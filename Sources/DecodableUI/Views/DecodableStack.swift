//
//  DecodableStack.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public struct DecodableStack: View {

    private let direction: Direction
    private let spacing: CGFloat?
    private let alignment: Alignment

    private let elements: [AnyView]

    private let viewModifier: DefaultDecodableViewModifier?

    public var body: some View {
        stack.optionalModifier(viewModifier)
    }

    public init(
        direction: Direction,
        spacing: CGFloat? = nil,
        alignment: Alignment? = nil,
        viewModifier: DefaultDecodableViewModifier? = nil,
        elements: [AnyView]
    ) {
        self.direction = direction
        self.spacing = spacing
        self.alignment = alignment ?? .center
        self.viewModifier = viewModifier
        self.elements = elements
    }

}

public extension DecodableStack {

    enum Direction: String, Decodable {
        case vertical
        case horizontal
    }

    enum Alignment: String, Decodable {

        case leading
        case trailing
        case top
        case bottom
        case center

        var horizontalAlignment: HorizontalAlignment {
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            default:
                return .center
            }
        }

        var verticalAlignment: VerticalAlignment {
            switch self {
            case .top:
                return .top
            case .bottom:
                return .bottom
            default:
                return .center
            }
        }

    }

}

private extension DecodableStack {

    @ViewBuilder
    private var stack: some View {
        if direction == .horizontal {
            HStack(alignment: alignment.verticalAlignment, spacing: spacing) { content }
        } else {
            VStack(alignment: alignment.horizontalAlignment, spacing: spacing) { content }
        }
    }

    private var content: some View {
        ForEach(elements.indices, id: \.self) { index in
            elements[index]
        }
    }

}

extension DecodableStack: DecodableView {

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

        let viewModifier = DefaultDecodableViewModifier(from: decoder)

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
