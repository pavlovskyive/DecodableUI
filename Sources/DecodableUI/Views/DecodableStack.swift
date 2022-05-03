//
//  DecodableStack.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

// TODO: Try to separate View logics from DecodableView logic. (DecodableStack: View, but extension to DecodableView)

public struct DecodableStack: DecodableView {

    private let direction: Direction
    private let spacing: CGFloat?
    private var alignment = Alignment.center

    private let elements: [AnyView]

    private let viewModifier: DefaultDecodableViewModifier?

    public var anyView: AnyView {
        AnyView(body)
    }

    public init?(from decoder: Decoder?, viewResolver: DecodableViewResolver) {
        guard let container = try? decoder?.container(keyedBy: CodingKeys.self),
              let direction = try? container.decode(Direction.self, forKey: .direction),
              let configurations = try? container.decode([DecodableViewConfiguration].self, forKey: .elements) else {
                  return nil
              }
        self.direction = direction
        self.elements = configurations.compactMap { configuration in
            viewResolver.resolve(from: configuration)?.anyView
        }
        if let alignment = try? container.decode(Alignment.self, forKey: .alignment) {
            self.alignment = alignment
        }
        self.spacing = try? container.decode(CGFloat.self, forKey: .spacing)

        self.viewModifier = DefaultDecodableViewModifier(from: decoder)
    }

}

private extension DecodableStack {

    var body: some View {
        stack.optionalModifier(viewModifier)
    }

    @ViewBuilder
    var stack: some View {
        if direction == .horizontal {
            HStack(alignment: alignment.verticalAlignment, spacing: spacing) { content }
        } else {
            VStack(alignment: alignment.horizontalAlignment, spacing: spacing) { content }
        }
    }

    var content: some View {
        ForEach(0..<elements.count, id: \.self) { index in
            elements[index]
        }
    }

}

private extension DecodableStack {

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

    enum CodingKeys: String, CodingKey {
        case direction
        case alignment
        case spacing
        case elements
    }

}
