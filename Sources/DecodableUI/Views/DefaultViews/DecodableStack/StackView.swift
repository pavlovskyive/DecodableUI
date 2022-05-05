//
//  DecodableStack.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public struct StackView<Modifier: ViewModifier>: View {

    private let direction: Direction
    private let spacing: CGFloat?
    private let alignment: Alignment

    private let elements: [AnyView]

    private let viewModifier: Modifier?

    public var body: some View {
        stack.optionalModifier(viewModifier)
    }

    public init(
        direction: Direction,
        spacing: CGFloat? = nil,
        alignment: Alignment? = nil,
        viewModifier: Modifier? = nil,
        elements: [AnyView]
    ) {
        self.direction = direction
        self.spacing = spacing
        self.alignment = alignment ?? .center
        self.viewModifier = viewModifier
        self.elements = elements
    }

}

public extension StackView {

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

private extension StackView {

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
