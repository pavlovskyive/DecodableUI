//
//  View+ClosureModifier.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 29.04.2022.
//

import SwiftUI

public extension View {

//    @ViewBuilder
//    func closureModifier<Content: View>(transform: (Self) -> Content) -> some View {
//        transform(self)
//    }
//
//    /// Applies the given transform if the given condition evaluates to `true`.
//    /// - Parameters:
//    ///   - condition: The condition to evaluate.
//    ///   - transform: The transform to apply to the source `View`.
//    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
//    @ViewBuilder
//    func conditionalModifier<Content: View>(
//        _ condition: @autoclosure () -> Bool,
//        transform: (Self) -> Content
//    ) -> some View {
//        if condition() {
//            transform(self)
//        } else {
//            self
//        }
//    }
//
//    func optionalModifier<T: Any>(
//        optional: T?,
//        unwrapedClosure: (T, Self) -> AnyView,
//        defaultClosure: (Self) -> AnyView
//    ) -> some View {
//        if let unwraped = optional {
//            return unwrapedClosure(unwraped, self)
//        } else {
//            return defaultClosure(self)
//        }
//    }

    @ViewBuilder
    func optionalModifier<T: ViewModifier>(_ viewModifier: T?) -> some View {
        if let viewModifier = viewModifier {
            modifier(viewModifier)
        } else {
            self
        }
    }

}
